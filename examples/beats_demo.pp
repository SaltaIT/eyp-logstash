class { 'logstash': }

logstash::input::beats { 'beats': }

logstash::output::elasticsearch { 'elasticsearch1':
  order => '00',
  hosts => [ '1.1.1.1' ],
  index => 'auditbeat-%{+YYYY.MM.dd}',
  conditional_output_field => 'auditbeat',
  conditional_output_value => true,
}

logstash::output::elasticsearch { 'elasticsearch2':
  order => '01',
  hosts => [ '2.2.2.2' ],
  index => 'filebeat-%{+YYYY.MM.dd}',
  conditional_output_statement => 'else if'
  conditional_output_field => 'filebeat',
  conditional_output_value => true,
}

logstash::output::elasticsearch { 'elasticsearch2':
  order => '03',
  hosts => [ '3.3.3.3' ],
  index => 'other-%{+YYYY.MM.dd}',
  conditional_output_statement => 'else'
}
