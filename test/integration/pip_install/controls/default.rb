control 'elasticsearch_curator_pip' do
  impact 1.0
  title 'Test configuration and install elasticsearch_curator'
  desc 'Test configuration and install elasticsearch_curator pip method'

  if os[:family] == 'debian'
    describe package('python-pip') do
      it { should be_installed }
    end
  elsif os[:family] == 'rhel'
    describe package('python2-pip') do
      it { should be_installed }
    end
  end

  describe package('python-setuptools') do
    it { should be_installed }
  end

  describe file('/home/curator/.curator/curator.yml') do
    it { should be_file }
    its(:mode) { should cmp '0400' }
    it { should be_owned_by 'curator' }
  end

  # Poise-python install virtualenv via pip, therefore resource package can't tell if it's install or not
  if os[:family] == 'debian'
    describe file('/usr/local/bin/virtualenv') do
      it { should be_file }
      it { should be_executable }
    end
  elsif os[:family] == 'rhel'
    describe file('/bin/virtualenv') do
      it { should be_file }
      it { should be_executable }
    end
  end

  describe command('python --version') do
    its(:exit_status) { should eq 0 }
  end

  # When installed via pip, package can't retrive the install

  describe file('/opt/elasticsearch-curator') do
    it { should be_directory }
  end

  describe file('/opt/elasticsearch-curator/bin/curator') do
    it { should be_file }
    its(:mode) { should cmp '0755' }
  end

  describe file('/opt/elasticsearch-curator/bin/curator_cli') do
    it { should be_file }
    its(:mode) { should cmp '0755' }
  end

  describe file('/opt/elasticsearch-curator') do
    it { should be_directory }
  end

  if os[:family] == 'debian'
    describe package('python-pkg-resources') do
      it { should be_installed }
    end
  end
end
