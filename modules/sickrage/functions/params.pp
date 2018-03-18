# unfortunately plex is all flat file config and the paths
# are stupid long like a java namespace :|

function sickrage::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_dir = '/var/lib/sickrage'
  $base_params = {
    'sickrage::base_dir'      => $base_dir,
    'sickrage::downloads_dir' => "${base_dir}/downloads",
    'sickrage::tv_dir'        => "${base_dir}/tv",
    'sickrage::config_dir'    => "${base_dir}/config",
  }

}
