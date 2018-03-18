# unfortunately plex is all flat file config and the paths
# are stupid long like a java namespace :|

function iapt::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_params = {
    'iapt::release' => $::lsbdistcodename,
  }

}
