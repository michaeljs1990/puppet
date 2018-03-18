# Pull down and configure docker version of sickrage

class sickrage::install () {

  require idocker

  $base = '/var/lib/sickrage'
  file {
    $base:
      ensure => 'directory';
    "${base}/config":
      ensure => 'directory';
    "${base}/downloads":
      ensure => 'directory';
    "${base}/tv":
      ensure => 'directory';
  }

  docker::run { 'sickrage':
    image         => 'linuxserver/sickrage',
    ports         => ['8080:8081'],
    volumes       => [
      "${base}/tv:/tv",
      "${base}/config:/config",
      "${base}/downloads:/downloads",
    ],
    env           => [
      'PGID=0',
      'PUID=0',
    ],
    pull_on_start => true,
    require       => [
      File["${base}/tv"],
      File["${base}/config"],
      File["${base}/downloads"],
    ]
  }

}
