function tautulli::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_dir = '/var/lib/tautulli'
  $base_params = {
    'tautulli::config_dir'    => $base_dir,
    'tautulli::plex_logs_dir' => '/var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Logs',
  }

}
