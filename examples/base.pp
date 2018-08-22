class { 'logstash': }

logstash::input::tcp { 'tcp-1234':
  port => '1234',
}

logstash::input::beats { 'beats': }

logstash::input::syslog { 'syslog': }

logstash::input::redis { 'redis': }

logstash::input::file { 'files':
  paths => [ '/var/log/messages', '/var/log/syslog' ],
}

logstash::output::elasticsearch { 'elasticsearch': }

logstash::customconf { 'demo':
  content => "# test\n",
}
