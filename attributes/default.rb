default['elasticsearch-curator']['version'] = nil
default['elasticsearch-curator']['install_method'] = 'package'
case node['platform_family']
when 'debian'
  default['elasticsearch-curator']['repository_url'] = 'http://packages.elastic.co/curator/4/debian'
when 'rhel'
  default['elasticsearch-curator']['repository_url'] = 'http://packages.elastic.co/curator/4/centos/7'
end
default['elasticsearch-curator']['repository_key'] = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
default['elasticsearch-curator']['bin_path'] = '/usr/bin'
default['elasticsearch-curator']['config'] = {
  'client' => {
    'hosts' => ['127.0.0.1'],
    'port' => 9200,
    'use_ssl' => false,
    'ssl_no_validate' => false,
    'timeout' => 30,
    'master_only' => false,
  },
  'logging' => {
    'loglevel' => 'INFO',
    'logformat' => 'default',
  },
}
default['elasticsearch-curator']['username'] = 'curator'
default['elasticsearch-curator']['config_file_path'] = "/home/#{node['elasticsearch-curator']['username']}/.curator"
default['elasticsearch-curator']['action_file_path'] = "/home/#{node['elasticsearch-curator']['username']}/.curator"
default['elasticsearch-curator']['cron_minute'] = '0'
default['elasticsearch-curator']['cron_hour'] = '*'
