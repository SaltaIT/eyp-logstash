# filter{
#     json{
#         source => "message"
#         target => "puppet-report"
#     }
# }
define logstash::jsonfilter (
                              $target          = $name,
                              $jsonfilter_name = $name,
                              $fields          = undef,
                            ) {
  file { "/etc/logstash/conf.d/55_filter_${jsonfilter_name}.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/jsonfilter.erb"),
    require => Package['logstash'],
    notify  => Service['logstash'],
  }
}
