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
  if platform_family?('debian')
    apt_repository 'elasticsearch-curator' do
      uri new_resource.repository_url
      distribution ''
      components %w(stable main)
      key new_resource.repository_key
      only_if { new_resource.install_method == 'package' }
    end
  elsif platform_family?('rhel')
    yum_repository 'elasticsearch-curator' do
      baseurl new_resource.repository_url
      gpgkey new_resource.repository_key
      only_if { new_resource.install_method == 'package' }
    end
  else
    Chef::Log.warn "I do not support your platform: #{node['platform_family']}"
  end

  if new_resource.install_method == 'package'
    package 'elasticsearch-curator' do
      version node['elasticsearch-curator']['version']
    end
    if platform_family?('debian')
      package 'python-pkg-resources'
    elsif platform_family?('rhel')
      package 'python-setuptools'
    end
  elsif new_resource.install_method == 'pip'
    package 'python-pip'
    node.override['poise-python']['provider'] = 'system'
    @run_context.include_recipe 'poise-python::default'
    python_virtualenv '/opt/elasticsearch-curator'
    python_package 'elasticsearch-curator' do
      version node['elasticsearch-curator']['version']
      action :install
    end
  else
    Chef::Application.fatal!("Unknown install method: #{@install_method}")
  end
end
