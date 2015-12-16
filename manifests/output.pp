define logstash::output (
                          $outputname=$name,
                          $elasticsearchhost=undef,
                          $elasticsearchport='9200',
                          $stdout_codec=undef,
                          $index=undef,
                        ) {

  # output {
  #   elasticsearch { host => localhost }
  #   stdout { codec => rubydebug }
  # }


  file { "/etc/logstash/conf.d/99_output_${outputname}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/output.erb"),
    require => Package['logstash'],
    notify  => Service['logstash'],
  }
}
