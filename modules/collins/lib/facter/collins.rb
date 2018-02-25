require 'collins_auth'
require 'socket'

# Collins facter is fairly strict as far as not letting you grab
# random attribs from collins. Although these can be super useful
# in speeding up development time in practice I have found that new
# people on the team obuse the crap out of it. 
#
# TODO: have an override in here for strange environment or test envs
# where facter will dropback to picking up the asset attribs from a
# flat file. This should make building things with packer super easy
# and make the puppet code much more portable.
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
