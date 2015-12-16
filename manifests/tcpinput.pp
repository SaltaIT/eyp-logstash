define logstash::tcpinput (
                            $type=$name,
                            $port='5999',
                            $codec=undef,
                            $tcpinput_name=$name,
                            $charset=undef,
                          ) {

  # input {
  #   tcp {
  #     type => "puppet-report"
  #     port => 5999
  #     codec => json
  #   }
  # }

  file { "/etc/logstash/conf.d/00_input_${tcpinput_name}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/tcpinput.erb"),
    require => Package['logstash'],
    notify  => Service['logstash'],
  }
}
