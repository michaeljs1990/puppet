class tautulli::install (
  String $config_dir,
  String $plex_logs_dir,
) {

  file { $config_dir:
    ensure => directory
  }

  docker::run { 'tautulli':
    image         => 'linuxserver/tautulli',
    ports         => [
      '8181:8181/tcp',
    ],
    volumes       => [
      "${config_dir}:/config",
      "${plex_logs_dir}:/logs:ro",
    ],
    env           => [
      'PLEX_UID=0',
      'PLEX_GID=0',
    ],
    pull_on_start => true,
    require       => [
      File[$config_dir],
    ]
  }

}
