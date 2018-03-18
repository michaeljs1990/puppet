# Base plex class that will install and then configure some
# base bones stuff for you.

class plex(
  String $base_dir,
  String $data_dir,
  String $transcode_dir,
  String $preferences_xml_path,
  String $wan_total_max_upload_rate,
  String $friendly_name,
  String $accepted_eula,
  String $log_debug
) {

  class { 'plex::install':
    base_dir      => $base_dir,
    data_dir      => $data_dir,
    transcode_dir => $transcode_dir,
  }
  -> class { 'plex::config':
    preferences_xml_path      => $preferences_xml_path,
    transcoder_temp_directory => $transcode_dir,
    wan_total_max_upload_rate => $wan_total_max_upload_rate,
    friendly_name             => $friendly_name,
    accepted_eula             => $accepted_eula,
    log_debug                 => $log_debug
  }

}
