# Pull down and configure docker version of sickrage

class sickrage::install (
  String $base_dir,
  String $config_dir,
  String $downloads_dir,
  String $tv_dir,
) {

  require idocker

  file {
    $base_dir:
      ensure => 'directory';
    $config_dir:
      ensure => 'directory';
    $downloads_dir:
      ensure => 'directory';
    $tv_dir:
      ensure => 'directory';
  }

  docker::run { 'sickrage':
    image         => 'linuxserver/sickrage',
    ports         => ['8080:8081'],
    volumes       => [
      "${tv_dir}:/tv",
      "${config_dir}:/config",
      "${downloads_dir}:/downloads",
    ],
    env           => [
      'PGID=0',
      'PUID=0',
    ],
    pull_on_start => true,
    require       => [
      File[$tv_dir],
      File[$config_dir],
      File[$downloads_dir],
    ]
  }

}
