# unfortunately plex is all flat file config and the paths
# are stupid long like a java namespace :|

function idocker::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_params = {
    'idocker::release' => "${::lsbdistcodename}"
  }

}
