# ServerSpec testing suited added by @GHostQC
require 'spec_helper'

describe package('elasticsearch-curator') do
  it { should be_installed }
end

describe file('/opt/elasticsearch-curator') do
  it { should be_directory }
end

# Test suites splitted between package install method and pip install method
if os[:family] == 'debian'
  describe package('python-pkg-resources') do
    it { should be_installed }
  end
# do nothing until I find how to test the APT repo
elsif os[:family] == 'rhel'
  describe package('python-setuptools') do
    it { should be_installed }
  end
  describe file('/etc/yum.repos.d/elasticsearch-curator.repo') do
    it { should be_file }
  end
end
