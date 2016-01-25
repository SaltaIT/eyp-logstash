require 'spec_helper'
describe 'logstash' do

  context 'CentOS 6' do

    let (:params) { { 'version' => '1.5' } }

    let :facts do
    {
      :osfamily => 'RedHat',
      :operatingsystem => 'CentOS',
      :operatingsystemrelease => '6.3',
    }
    end

    it { should contain_class('logstash') }

    it { should contain_package('logstash')}

    it { should contain_service('logstash')}
  end

  context 'CentOS 7' do

    let (:params) { { 'version' => '1.5' } }

    let :facts do
    {
      :osfamily => 'RedHat',
      :operatingsystem => 'CentOS',
      :operatingsystemrelease => '7.3',
    }
    end

    it { should contain_class('logstash') }

    it { should contain_package('logstash')}

    it { should contain_service('logstash')}
  end

  context 'unsupported OS' do
    let :facts do
    {
            :osfamily => 'SOFriki',
    }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end
end
