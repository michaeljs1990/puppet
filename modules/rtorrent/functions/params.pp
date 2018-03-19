function rtorrent::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_dir = '/var/lib/rtorrent'

  $base_params = {
    'rtorrent::config_dir'    => $base_dir,
    'rtorrent::downloads_dir' => "${base_dir}/downloads",
  }

}
