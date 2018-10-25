define logstash::output::elasticsearch(
                                        $id                           = $name,
                                        $order                        = '00',
                                        $hosts                        = [ '127.0.0.1' ],
                                        $index                        = undef,
                                        $conditional_output_statement = 'if',
                                        $conditional_output_field     = undef,
                                        $conditional_output_value     = '',
                                        $conditional_output_condition = '==',
                                      ) {
  if(!defined(Concat['/etc/logstash/conf.d/99_output.conf']))
  {
    concat { '/etc/logstash/conf.d/99_output.conf':
      ensure => 'present',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      notify => Class['::logstash::service'],
    }

    concat::fragment{ 'logstash 99_output.conf header':
      target  => '/etc/logstash/conf.d/99_output.conf',
      order   => 'a00',
      content => "output {\n",
    }

    concat::fragment{ 'logstash 99_output.conf end':
      target  => '/etc/logstash/conf.d/99_output.conf',
      order   => 'z99',
      content => "\n}\n",
    }
  }

  concat::fragment{ "logstash 99_output.conf elasticsearch ${id}":
    target  => '/etc/logstash/conf.d/99_output.conf',
    order   => "b42-${order}",
    content => template("${module_name}/output/elasticsearch.erb"),
  }

}
