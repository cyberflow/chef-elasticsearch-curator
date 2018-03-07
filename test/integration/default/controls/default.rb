control 'elasticsearch_curator_default' do
  impact 1.0
  title 'Test configuration and install elasticsearch_curator'
  desc 'Test configuration and install elasticsearch_curator package method'

  describe package('elasticsearch-curator') do
    it { should be_installed }
  end

  describe file('/opt/elasticsearch-curator') do
    it { should be_directory }
  end

  describe file('/home/curator/.curator/curator.yml') do
    it { should be_file }
    its(:mode) { should cmp '0400' }
    it { should be_owned_by 'curator' }
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
end
