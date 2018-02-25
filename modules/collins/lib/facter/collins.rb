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

    # determine the site from the hostname
    site = asset.hostname.split('.').at 1
    collins_hash = {
      :tag            => asset.tag,
      :pool           => asset.pool,
      :site           => site,
      :state          => asset.state.label,
      :status         => asset.status,
      :hostname       => asset.hostname,
      :password       => asset.password,
      :nodeclass      => asset.nodeclass,
      :environment    => asset.environment,
      :primary_role   => asset.primary_role,
      :rack_position  => asset.rack_position,
      :secondary_role => asset.secondary_role
    }

    collins_hash
  end
end
