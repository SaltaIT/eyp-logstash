Puppet::Type.newtype(:logstash_plugin) do
  @doc = 'Manage logstash plugins'

  ensurable

  autorequire(:package) do
    'elasticsearch'
  end

  newparam(:name, :namevar => true) do
    desc 'plugin to manage'

    validate do |value|
      unless value.is_a?(String)
        raise Pupper::Error,
          "not a string, modafuca"
      end
    end
  end

end
