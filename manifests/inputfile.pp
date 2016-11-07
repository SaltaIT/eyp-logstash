define logstash::inputfile(
                            $filename,
                            $desc = $name,
                          ) {

  file { "/etc/logstash/conf.d/00_input_file_${desc}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/inputfile.erb"),
    notify  => Service['logstash'],
    require => Package['logstash'],
  }
}
