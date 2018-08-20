class logstash::params {

  $package_name='logstash'
  $service_name='logstash'

  case $::osfamily
  {
    'redhat' :
    {
      case $::operatingsystemrelease
      {
        /^7.*$/:
        {
          $package_url='https://artifacts.elastic.co/downloads/logstash/logstash-6.3.1.rpm'
          $package_provider = 'rpm'
          $postinstall_action = '/usr/share/logstash/bin/system-install /etc/logstash/startup.options systemd'
          $postinstall_creates = '/etc/systemd/system/logstash.service'
        }
        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }
}
