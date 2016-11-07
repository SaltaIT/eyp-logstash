define logstash::addconf(
                          $source,
                          $desc     = $name,
                          $priority = '00',
                        ) {

  file { "/etc/logstash/conf.d/${priority}_addconf_${desc}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $source,
    notify  => Service['logstash'],
    require => Package['logstash'],
  }
}
