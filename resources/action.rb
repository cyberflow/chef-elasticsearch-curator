# resources/action.rb
#
# Cookbook Name:: elasticsearch-curator
# Resource:: action
#
# Copyright 2016 Servers.com
#

property :name, String, name_property: true
property :config, Hash, default: {}
property :username, String, default: node['elasticsearch-curator']['username']
property :minute, String, default: node['elasticsearch-curator']['cron_minute']
property :hour, String, default: node['elasticsearch-curator']['cron_hour']
property :path, String, default: node['elasticsearch-curator']['action_file_path']

default_action :create

action :create do
  directory path do
    recursive true
    action :create
  end

  require 'yaml'

  file "#{path}/#{name}.yml" do
    content YAML::dump(config.to_hash)
    user user
    mode '0644'
  end

  curator_args = "--config #{node['elasticsearch-curator']['config_file_path']}/curator.yml #{path}/#{name}.yml"
  cr = cron "curator-#{cur_instance}" do
    command "/usr/local/bin/curator #{curator_args}"
    user    username
    minute  minute
    hour    hour
    action  [:create]
  end
  new_resource.updated_by_last_action(cr.updated_by_last_action?)
end