class logstash::config inherits logstash {
  exec { 'postinstall action':
    command => $logstash::params::postinstall_action,
    creates => $logstash::params::postinstall_creates,
    path    => '/usr/sbin:/usr/bin:/sbin :/bin'
  }
}
