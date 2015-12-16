define logstash::input(
                        $type=$name,
                        $input_name=$name,
                        $properties=undef,
                      ) {

  if($properties)
  {
    validate_hash($properties)
  }

  file { "/etc/logstash/conf.d/00_input_${input_name}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/input.erb"),
    notify  => Service['logstash'],
    require => Package['logstash'],
  }
}
