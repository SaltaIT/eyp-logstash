class { 'logstash': }

logstash::input::beats { 'beats': }

logstash::output::elasticsearch { 'elasticsearch': }
