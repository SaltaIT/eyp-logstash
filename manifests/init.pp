#
class logstash($version='1.5') inherits logstash::params {

  Exec {
    path => '/sbin:/bin:/usr/sbin:/usr/bin',
  }

  # logstash require Java
  if(defined(Class['java']))
  {
    $java_before=Class['java']
  }
  else
  {
    $java_before=undef
  }

  exec { 'check java logstash':
    command => 'update-alternatives --display java',
    require => $java_before,
  }

  yumrepo { "logstash-${version}":
    baseurl  => "http://packages.elasticsearch.org/logstash/${version}/centos",
    descr    => "logstash repository for ${version}.x packages",
    enabled  => '1',
    gpgcheck => '0',
    gpgkey   => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  }

  package { 'logstash':
    ensure  => 'installed',
    require => [ Yumrepo["logstash-${version}"], Exec['check java logstash'] ],
  }

  service { 'logstash':
    ensure  => 'running',
    enable  => true,
    require => Package['logstash'],
  }

  if(defined(Class['logrotate']))
  {
    logrotate::logs { 'logstashLog':
      ensure        => present,
      log           => '/var/log/logstash/logstash.log',
      rotate        => '7',
      compress      => true,
      delaycompress => true,
      notifempty    => true,
      frequency     => 'daily',
      missingok     => true,
      dateext       => false,
      copytruncate  => true,
    }

    logrotate::logs { 'logstashErr':
      ensure        => present,
      log           => '/var/log/logstash/logstash.err',
      rotate        => '7',
      compress      => true,
      delaycompress => true,
      notifempty    => true,
      frequency     => 'daily',
      missingok     => true,
      dateext       => false,
      copytruncate  => true,
    }

    logrotate::logs { 'logstashStdout':
      ensure        => present,
      log           => '/var/log/logstash/logstash.stdout',
      rotate        => '7',
      compress      => true,
      delaycompress => true,
      notifempty    => true,
      frequency     => 'daily',
      missingok     => true,
      dateext       => false,
      copytruncate  => true,
    }
}
