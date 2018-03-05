# Puppet DC

Example of how to setup puppet in an environment in which you own the entire
provisioning stack. This is based around masterless puppet and puppet 5.4 using
tumblr/collins as the CMDB although any can be used.

## INFO

Right now this is largely based around the nix puppet install. This can be
seen when looking at pathing used in scripts such as `/opt/puppetlabs/puppet/bin/ruby`.
This will be cleaned up later but is used right now for convenience.
