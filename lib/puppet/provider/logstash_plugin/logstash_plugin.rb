Puppet::Type.type(:logstash_plugin).provide(:logstash_plugin) do
  desc 'logstash plugin provider'

  commands :logstash_plugin => '/opt/logstash/bin/plugin'

  def self.instances
    logstash_plugin(['list']).split("\n").collect do |package|
      new(:name => package,
          :ensure => :present
        )
    end
  end

  def self.prefetch(resources)
    resources.keys.each do |name|
      if provider = instances.find{ |instance| instance.name == name }
        resources[name].provider = provider
        debug "prefetch name:"+name+" instances.name:"+instance.name
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present || false
  end

  def create
    debug 'install '+resource[:name]
    logstash_plugin(['install', resource[:name] ])
  end

  def destroy
    debug 'uninstall '+resource[:name]
    logstash_plugin(['uninstall', resource[:name] ])
  end

end
