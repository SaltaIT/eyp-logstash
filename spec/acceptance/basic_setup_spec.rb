require 'spec_helper_acceptance'

describe 'logstash class' do

  context 'basic setup ' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'logstash': }

      logstash_plugin { 'logstash-input-puppet_facter':
        ensure => 'present',
      }

      logstash::tcpinput { 'puppet-report':
        port => '5959',
      }

      logstash::output { 'out':
        elasticsearchhost => '127.0.0.1',
        stdout_codec => 'rubydebug',
      }

      logstash::jsonfilter { 'puppet-report':
        fields => {
          'success' => '[puppet-report][metrics][events][success]',
          'failure' => '[puppet-report][metrics][events][failure]'
        }
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)

    end

    it "sleep 60 to make sure logstash is started" do
      expect(shell("sleep 60").exit_code).to be_zero
    end

    # it "check db and mysql access" do
    #   expect(shell("echo show databases | mysql | grep et2blog").exit_code).to be_zero
    # end

    describe port(5959) do
      it { should be_listening }
    end

    describe file("/etc/logstash/conf.d/00_input_puppet-report.conf") do
      it { should be_file }
      its(:content) { should match 'puppet-report' }
    end

    describe file("/etc/logstash/conf.d/55_filter_puppet-report.conf") do
      it { should be_file }
      its(:content) { should match 'puppet-report' }
      its(:content) { should match 'json' }
    end

    describe file("/etc/logstash/conf.d/99_output_out.conf") do
      it { should be_file }
      its(:content) { should match 'rubydebug' }
    end

  end

end
