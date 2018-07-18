define logstash::input::redis(
                                $id        = $name,
                                $host      = '127.0.0.1',
                                $port      = '6379',
                                $data_type = undef,
                                $key       = undef,
                                $order     = '42',
                              ) {
  if(!defined(Concat['/etc/logstash/conf.d/00_input.conf']))
  {
    concat { '/etc/logstash/conf.d/00_input.conf':
      ensure => 'present',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }

    concat::fragment{ 'logstash 00_input.conf header':
      target  => '/etc/logstash/conf.d/00_input.conf',
      order   => '00',
      content => "input {\n",
    }

    concat::fragment{ 'logstash 00_input.conf end':
      target  => '/etc/logstash/conf.d/00_input.conf',
      order   => '99',
      content => "\n}\n",
    }
  }

  concat::fragment{ "logstash 00_input.conf redis ${id}":
    target  => '/etc/logstash/conf.d/00_input.conf',
    order   => "42-${order}",
    content => template("${module_name}/input/redis.erb"),
  }

}
