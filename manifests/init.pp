#
class logstash inherits logstash::params {

  Exec {
    path => '/sbin:/bin:/usr/sbin:/usr/bin',
  }

  # logstash require Java
  if(defined(Class['java']))
  {
    $java_before=Class['java']
  }

  exec { 'check java logstash':
    command => 'update-alternatives --display java',
    require => $java_before,
  }

  yumrepo { 'logstash-1.5':
    baseurl => 'http://packages.elasticsearch.org/logstash/1.5/centos',
    descr => 'logstash repository for 1.5.x packages',
    enabled => '1',
    gpgcheck => '0',
    gpgkey => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  }

  package { 'logstash':
    ensure => 'installed',
    require => [ Yumrepo['logstash-1.5'], Exec['check java logstash'] ],
  }

  service { 'logstash':
    ensure => 'running',
    enable => true,
    require => Package['logstash'],
  }

}
