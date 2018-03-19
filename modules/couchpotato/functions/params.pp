function couchpotato::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_dir = '/var/lib/couchpotato'
  $base_params = {
    'couchpotato::base_dir'      => $base_dir,
    'couchpotato::movies_dir'    => "${base_dir}/movies",
    'couchpotato::downloads_dir' => "${base_dir}/downloads",
  }

}
