# ServerSpec testing suited added by @GHostQC
require 'spec_helper'

describe package('pip') do
	it { should be_installed }
end

describe package('python-setuptools') do
	it { should be_installed }
end

describe package('python-virtualenv') do
	it { should be_installed }
end

describe command('python --version') do
	its(:exit_status) { should eq 0 }
end

describe package('elasticsearch-curator') do
	it { should be_installed }
end

describe file('/opt/elasticsearch-curator') do
	it { should be_directory }
end

if ['debian','ubuntu'].include?(os[:family])
	describe package('python-pkg-resources') do
		it { should be_installed }
	end
end

