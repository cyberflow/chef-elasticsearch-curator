# resources/action.rb
#
# Cookbook Name:: elasticsearch-curator
# Resource:: action
#
# Copyright 2016 Servers.com
#

property :config, Hash, default: {}
property :username, String, default: node['elasticsearch-curator']['username']
property :minute, String, default: node['elasticsearch-curator']['cron_minute']
property :hour, String, default: node['elasticsearch-curator']['cron_hour']
property :path, String, default: node['elasticsearch-curator']['action_file_path']
property :bin_path, String, default: node['elasticsearch-curator']['bin_path']

default_action :create

action :create do
  directory new_resource.path do
    recursive true
    action :create
  end

  require 'yaml'

  file "#{new_resource.path}/#{new_resource.name}.yml" do
    content YAML.dump(new_resource.config.to_hash)
    user new_resource.username
    mode '0644'
  end

  curator_args = "--config #{node['elasticsearch-curator']['config_file_path']}/curator.yml #{new_resource.path}/#{new_resource.name}.yml"
  cron_d "curator-#{new_resource.name}" do
    command "#{new_resource.bin_path}/curator #{curator_args}"
    user    new_resource.username
    minute  new_resource.minute
    hour    new_resource.hour
    action  [:create]
  end
end
