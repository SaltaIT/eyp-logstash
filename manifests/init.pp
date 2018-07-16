#
class logstash(
                $manage_package        = true,
                $package_ensure        = 'installed',
                $manage_service        = true,
                $manage_docker_service = true,
                $service_ensure        = 'running',
                $service_enable        = true,
              ) inherits logstash::params {
  class { '::logstash::install': }
  -> class { '::logstash::config': }
  ~> class { '::logstash::service': }
  -> Class['::logstash']
}
