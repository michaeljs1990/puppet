# unfortunately plex is all flat file config and the paths
# are stupid long like a java namespace :|

function plex::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $plexpath = '/var/lib/plexmediaserver'
  $base_params = {
    'plex::base_dir'                  => $plexpath,
    'plex::data_dir'                  => "${plexpath}/shows",
    'plex::transcode_dir'             => "${plexpath}/transcode",
    # Plex XML Configuration
    'plex::preferences_xml_path'      => "${plexpath}/Library/Application Support/Plex Media Server/Preferences.xml",
    'plex::wan_total_max_upload_rate' => '150000',
    'plex::friendly_name'             => 'plex-media',
    'plex::accepted_eula'             => '1',
    'plex::log_debug'                 => '1'
  }

}
