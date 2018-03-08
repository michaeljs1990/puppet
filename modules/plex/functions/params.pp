function plex::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_params = {
    # Create a ramdisk to significantly speed up transcoding
    'plex::ramdisk'                   => false,
    'plex::preferences_xml_path'      => '/var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml',
    'plex::transcoder_temp_directory' => '/tmp/transcode',
    'plex::wan_total_max_upload_rate' => '150000',
    'plex::friendly_name'             => 'plex-media',
    'plex::accepted_eula'             => '1',
    'plex::log_debug'                 => '1',
  }

}
