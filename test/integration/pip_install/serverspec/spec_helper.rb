# spec_helper.rb created by @GHostQC
require 'serverspec'

set :backend, :exec

set :path, '/sbin:/usr/local/sbin:/opt/elasticsearch-curator:$PATH'
