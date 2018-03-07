# resources/config.rb
#
# Cookbook Name:: elasticsearch-curator
# Resource:: config
#
# Copyright 2016 Servers.com
#

property :config, Hash, default: {}
property :username, String, default: node['elasticsearch-curator']['username']
property :path, String, default: node['elasticsearch-curator']['config_file_path']
property :http_auth, [String, nil], default: nil
default_action :configure

action :configure do
  user new_resource.username do
    system true
    action :create
    manage_home true
  end

  group new_resource.username do
    members new_resource.username
    append true
    system true
  end

  directory path do
    recursive true
    action :create
  end

  require 'yaml'

  curatorconfig = config.to_hash.clone

  if !http_auth.nil? && http_auth.length > 2 && http_auth.include?(':')
    curatorconfig['client']['http_auth'] = http_auth
  end

  file "#{path}/curator.yml" do
    content YAML.dump(curatorconfig.to_hash)
    user new_resource.username
    mode '0400'
    sensitive true
  end
end
