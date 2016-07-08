# resources/install.rb
#
# Cookbook Name:: elasticsearch-curator
# Resource:: install
#
# Copyright 2016 Servers.com
#

property :arch_type, kind_of: String
property :install_method, kind_of: String, default: 'package'
property :repository_url, kind_of: String, default: node['elasticsearch-curator']['repository_url']
property :repository_key, kind_of: String, default: node['elasticsearch-curator']['repository_key']
property :install_version, [String, nil],  default: nil
default_action :install

action :install do
  if node.platform_family? 'debian'
    apt_repository 'elasticsearch-curator' do
      uri new_resource.repository_url
      distribution ''
      components %w(stable main)
      key new_resource.repository_key
      only_if { new_resource.install_method == 'package' }
    end
  else
    Chef::Log.warn "I do not support your platform: #{node['platform_family']}"
  end

  if new_resource.install_method == 'package'
    package 'python-elasticsearch-curator'
    package 'python-pkg-resources'
  elsif new_resource.install_method == 'pip'
    @run_context.include_recipe 'poise-python::default'
    pi = python_package 'elasticsearch-curator' do
      version node['elasticsearch-curator']['version']
      action :install
    end
    new_resource.updated_by_last_action(pi.updated_by_last_action?)
  else
    Chef::Application.fatal!("Unknown install method: #{@install_method}")
  end
end
