define logstash::output::elasticsearch(
                                        $id    = $name,
                                        $order = '42',
                                        $hosts = [ '127.0.0.1' ],
                                        $index = undef,
                                      ) {
  if(!defined(Concat['/etc/logstash/conf.d/99_output.conf']))
  {
    concat { '/etc/logstash/conf.d/99_output.conf':
      ensure => 'present',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }

    concat::fragment{ 'logstash 99_output.conf header':
      target  => '/etc/logstash/conf.d/99_output.conf',
      order   => '00',
      content => "output {\n",
    }

    concat::fragment{ 'logstash 99_output.conf end':
      target  => '/etc/logstash/conf.d/99_output.conf',
      order   => '99',
      content => "\n}\n",
    }
  }

  concat::fragment{ "logstash 99_output.conf elasticsearch ${id}":
    target  => '/etc/logstash/conf.d/99_output.conf',
    order   => "42-${order}",
    content => template("${module_name}/output/elasticsearch.erb"),
  }

}
