define logstash::input::tcp(
                              $port,
                              $id      = $name,
                              $host    = '0.0.0.0',
                              $codec   = undef,
                              $charset = undef,
                              $order   = '42',
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

  concat::fragment{ "logstash 00_input.conf tcp ${id}":
    target  => '/etc/logstash/conf.d/00_input.conf',
    order   => "42-${order}",
    content => template("${module_name}/input/tcp.erb"),
  }

}
