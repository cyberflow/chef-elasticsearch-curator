# elasticsearch-curator [![Cookbook Version](http://img.shields.io/cookbook/v/elasticsearch-curator.svg)](https://community.opscode.com/cookbooks/elasticsearch-curator) [![Build Status](https://travis-ci.org/cyberflow/chef-elasticsearch-curator.svg?branch=master)](https://travis-ci.org/cyberflow/chef-elasticsearch-curator)

Chef cookbook to install and configure [elasticsearch-curator](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html) from version 4.

## Tested Platforms

* ubuntu 14.04
* centos 7.2

## Usage

This cookbook can be used by including `elasticsearch-curator::default` in your run list and settings attributes as needed.  Alternatively, you can use the custom resources directly.

If you are using elasticsearch-curator < 4.2 you might want to use the cookbook version 0.1.4.

### Attributes

| Key                                  | Type   | Description                                           | Default                                                                                                                                                             |
|--------------------------------------|--------|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| node['elasticsearch-curator']['version']          | String | Version of elasticsearch-curator to install, nil = latest | nil |
| node['elasticsearch-curator']['repository_url'] | String | URL of elasticsearch-curator package repository | 'http://packages.elastic.co/curator/4/debian' |
| node['elasticsearch-curator']['repository_key']           | String   | elasticsearch-curator repository key | 'https://packages.elastic.co/GPG-KEY-elasticsearch' |
| node['elasticsearch-curator']['bin_path'] | String | bin path for elasticsearch-curator | '/usr/bin' |
|node['elasticsearch-curator']['username']|String|user for running curator|'curator'|
|node['elasticsearch-curator']['config_file_path']|String|path to direct curator config file|"/home/#{node['elasticsearch-curator']['username']}/.curator"|
|node['elasticsearch-curator']['action_file_path']|String|path to direct action config file|"/home/#{node['elasticsearch-curator']['username']}/.curator"|
|node['elasticsearch-curator']['cron_minute']|String|Minute to run the curator cron job|'0'|
|node['elasticsearch-curator']['cron_hour']|String|Hour to run the curator cron job|'*'|
|node['elasticsearch-curator']['config']|Hash|config elasticsearch-curator| {<br>&nbsp;&nbsp;'client' => {<br>&nbsp;&nbsp;&nbsp;&nbsp;'hosts' => ['127.0.0.1'],<br>&nbsp;&nbsp;&nbsp;&nbsp;'port' => 9200,<br>&nbsp;&nbsp;&nbsp;&nbsp;'use_ssl' => false,<br>&nbsp;&nbsp;&nbsp;&nbsp;'ssl_no_validate' => false,<br>&nbsp;&nbsp;&nbsp;&nbsp;'timeout' => 30,<br>&nbsp;&nbsp;&nbsp;&nbsp;'master_only' => false<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;'logging' => {<br>&nbsp;&nbsp;&nbsp;&nbsp;'loglevel' => 'INFO',<br>&nbsp;&nbsp;&nbsp;&nbsp;'logformat' => 'default'<br>&nbsp;&nbsp;}<br>}|

This cookbook ships with custom resources for install elasticsearch-curator and managing the configuration file:

### Custom Resources

#### elasticsearch_curator_install

Installs elasticsearch-curator. Optionally specifies a version, otherwise the latest available is installed

```ruby
elasticsearch_curator_install 'curator' do
  install_method node['elasticsearch-curator']['install_method']
  action :install
end
```

#### elasticsearch_curator_config

Writes out the elasticsearch-curator configuration file.

```ruby
elasticsearch_curator_config 'default' do
  config node['elasticsearch-curator']['config']
  action :configure
end
```
This method also supports a http_auth property to allow passing a string with this format : "username:password". This allows retrieving the credentials from the wrapper cookbook (for example using chef-vault) and not store this sensitive information in the attributes.

#### elasticsearch_curator_action

This will setup a cron job and create action.yaml file for elasticsearch-curator.

```ruby
elasticsearch_curator_action 'action' do
  config node['elasticsearch-curator']['action_config']
  minute '0'
  hour '*'
  action :create
end
```

## Tests

To run tests, install all dependencies with [bundler](http://bundler.io/):

    bundle install
    bundle exec cookstyle
    bundle exec foodcritic .
