# resources/config.rb
#
# Cookbook Name:: elasticsearch-curator
# Resource:: config
#
# Copyright 2016 Servers.com
#

property :name, String, name_property: true
property :config, Hash, default: {}
property :username, String, default: node['elasticsearch-curator']['username']
property :path, String, default: node['elasticsearch-curator']['config_file_path']

default_action :configure

action :configure do
  ur = user new_resource.username do
    system true
    action :create
    manage_home true
  end
  new_resource.updated_by_last_action(ur.updated_by_last_action?)

  gr = group new_resource.username do
    members new_resource.username
    append true
    system true
  end
  new_resource.updated_by_last_action(gr.updated_by_last_action?)

  directory path do
    recursive true
    action :create
  end

  require 'yaml'

  file "#{path}/curator.yml" do
    content YAML.dump(config.to_hash)
    user user
    mode '0644'
  end
end
