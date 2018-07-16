class logstash::install inherits logstash {

  if($logstash::manage_package)
  {
    package { $logstash::params::package_name:
      ensure   => $logstash::package_ensure,
      source   => $logstash::params::package_url,
      provider => $logstash::params::package_provider,
    }
  }

}
