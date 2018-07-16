class logstash::service inherits logstash {

  #
  validate_bool($logstash::manage_docker_service)
  validate_bool($logstash::manage_service)
  validate_bool($logstash::service_enable)

  validate_re($logstash::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${logstash::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $logstash::manage_docker_service)
  {
    if($logstash::manage_service)
    {
      service { $logstash::params::service_name:
        ensure => $logstash::service_ensure,
        enable => $logstash::service_enable,
      }
    }
  }
}
