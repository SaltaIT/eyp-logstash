define logstash::inputredis (
                              $redishost = $name,
                              $redisport = '6379',
                              $key       = 'logstash',
                              $codec     = 'json',
                              $data_type = 'list',
                            ) {

  file { "/etc/logstash/conf.d/00_input_redis_${redishost}_${redisport}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/input/inputredis.erb"),
    notify  => Service['logstash'],
    require => Package['logstash'],
  }
}
