require 'collins_auth'
require 'socket'

Facter.add(:collins) do
  setcode do
    collins_hash = {}

    # Create a client from COLLINS_CLIENT_CONFIG, ~/.collins.yml, 
    # /etc/collins.yml, or /var/db/collins.yml
    hostname = Socket.gethostname
    client = Collins::Authenticator.setup_client
    asset = (client.find hostname: hostname).first

    collins_hash = {
      :hostname => asset.hostname,
      :password => asset.password,
      :nodeclass => asset.nodeclass,
      :primary_role => asset.primary_role,
      :secondary_role => asset.secondary_role,
      :pool => asset.pool,
      :tag => asset.tag,
      :status => asset.status,
      :state => asset.state.label,
      :rack_position => asset.rack_position
    }

    collins_hash
  end
end
