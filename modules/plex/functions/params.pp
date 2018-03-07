function plex::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_params = {
    # Create a ramdisk to significantly speed up transcoding
    'plex::ramdisk' => false,
  }

}
