# This is not optimal but config for plex is done in an XML
# file and a flat file DB. Right now this just supports the
# minimum amount of parameters needed to start syncing all
# of your shows. Additionally you can prefetch the DB to save
# yourself a lot of time on syncing.

class plex::config (
  String $preferences_xml_path,
  String $transcoder_temp_directory,
  String $wan_total_max_upload_rate,
  String $friendly_name,
  String $accepted_eula,
  String $log_debug,
) {

  $config = {
    'TranscoderTempDirectory' => $transcoder_temp_directory, 
    'WanTotalMaxUploadRate'   => $wan_total_max_upload_rate,
    'FriendlyName'            => $friendly_name,
    'AcceptedEULA'            => $accepted_eula,
    'LogDebug'                => $log_debug
  }

  $config.each |$key, $value| {
    augeas { "Set ${key} in ${preferences_xml_path}":
      incl    => $preferences_xml_path,
      lens    => 'Xml.lns',
      context => "/files$preferences_xml_path/Preferences",
      changes => [
        "set #attribute/$key $value"
      ]
    }
  }

  # Create the transcoder temp directory and set perms
  file { $transcoder_temp_directory:
    ensure  => 'directory',
    owner   => 'plex',
    group   => 'plex'
  }

  include python::pipenv

}
