define logstash::customconf (
                              $content,
                              $ensure   = 'present',
                              $filename = $name,
                              $order    = '42',
                            ) {
  file { "/etc/logstash/conf.d/${order}_${filename}.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Class['::logstash::service'],
    content => $content,
  }
}
