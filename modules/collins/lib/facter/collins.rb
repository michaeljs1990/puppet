require 'collins_auth'
require 'json'
require 'ostruct'
require 'socket'

# Collins facter is fairly strict as far as not letting you grab
# random attribs from collins. Although these can be super useful
# in speeding up development time in practice I have found that new
# people on the team obuse the crap out of it. 
Facter.add(:collins) do
  setcode do
    collins_hash = {}
    static_file = "/etc/collins.json"

    # Create a client from COLLINS_CLIENT_CONFIG, ~/.collins.yml, 
    # /etc/collins.yml, or /var/db/collins.yml
    begin
      hostname = Socket.gethostname
      Facter.debug "Pulling asset from collins remote DB using: #{hostname}"
      client = Collins::Authenticator.setup_client
      asset = (client.find hostname: hostname).first
    rescue => ex
      # This is an expected condition but leave this here to easily turn on logging
      # Facter.log_exception ex
      Facter.warn "Collins lookup failed. pulling asset from disk: #{static_file}"

      asset = nil
      File.open(static_file, "r") do |f|
        json_hash = JSON.parse(f.read)
        # Cleanup to make the JSON look like collins returned it or in other
        # words move asset.state to asset.state.label and make this feel like
        # an object. This can likely be done a nicer way but it escapes me at
        # this time sorry :(.
        asset = OpenStruct.new(json_hash) 
        state = asset.state
        asset.state = OpenStruct.new(:label => state)
      end
   end

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

    begin
      # Write the above collins info out to a flat file for future use.
      File.open(static_file, "w") do |f|
        f.write(JSON.pretty_generate(collins_hash))
      end
    rescue => ex
      Facter.log_exception ex
    end

    collins_hash
  end
end
