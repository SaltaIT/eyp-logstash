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

  # def self.prefetch(resources)
  #   dbs=instances
  #   resources.keys.each do |name|
  #     if provider = dbs.find{ |db| db.name == name }
  #       resources[name].provider = provider
  #       debug "prefetch name:"+name+" instances.name:"+db.name
  #     end
  #   end
  # end

  def self.prefetch(resources)
    databases = instances
    resources.keys.each do |database|
      if provider = databases.find { |db| db.name == database }
        resources[database].provider = provider
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
