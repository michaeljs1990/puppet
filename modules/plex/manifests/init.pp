# Base plex class that will install and then configure some
# base bones stuff for you.

class plex(
  String $preferences_xml_path,
  String $transcoder_temp_directory,
  String $wan_total_max_upload_rate,
  String $friendly_name,
  String $accepted_eula,
  String $log_debug
) {

  class { 'plex::install': }
  -> service{ 'plexmediaserver':
    ensure  => 'running',
    enable  => true,
    start   => 'service plexmediaserver start',
    stop    => 'service plexmediaserver stop',
    restart => 'service plexmediaserver restart',
  }

  class { 'plex::config':
    preferences_xml_path      => $preferences_xml_path,
    transcoder_temp_directory => $transcoder_temp_directory,
    wan_total_max_upload_rate => $wan_total_max_upload_rate,
    friendly_name             => $friendly_name,
    accepted_eula             => $accepted_eula,
    log_debug                 => $log_debug
  }

}
