#
# Cookbook Name:: elasticsearch-curator
# Recipe:: default
#
# Copyright (C) 2016
#
#
#

elasticsearch_curator_install 'curator' do
  install_method node['elasticsearch-curator']['install_method']
  action :install
end

elasticsearch_curator_config 'default' do
  config node['elasticsearch-curator']['config']
  action :configure
end
