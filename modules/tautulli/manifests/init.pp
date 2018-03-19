# Install tautulli which offers some cool insight into the usage of plex
# we require plex since the log files have to be available for mounting them
# into the docker container.

class tautulli (
  String $config_dir,
  String $plex_logs_dir,
) {

  require plex

  class { 'tautulli::install':
    config_dir    => $config_dir,
    plex_logs_dir => $plex_logs_dir,
  }

}
