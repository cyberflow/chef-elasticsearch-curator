name             'elasticsearch-curator'
maintainer       'servers.com'
maintainer_email 'dmitry.r@cyberflow.net'
license          'MIT'
description      'Installs/Configures elasticsearch-curator'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.8'

%w(ubuntu debian centos redhat).each do |os|
  supports os
end

%w(apt poise-python cron yum-epel yum).each do |ckbk|
  depends ckbk
end

# For compatibility with 12.X versions of Chef
depends 'compat_resource'

chef_version '>= 12.9' if respond_to?(:chef_version)
source_url 'https://github.com/cyberflow/chef-elasticsearch-curator' if respond_to?(:source_url)
issues_url 'https://github.com/cyberflow/chef-elasticsearch-curator/issues' if respond_to?(:issues_url)
