class couchpotato::install(
  String $base_dir,
  String $movies_dir,
  String $downloads_dir,
) {

  require idocker

  if couchpotato::params({}, Puppet::LookupContext.new('m'))['couchpotato::base_dir'] == $base_dir {
    file { $base_dir:
      ensure => 'directory';
    }
  }

  if couchpotato::params({}, Puppet::LookupContext.new('m'))['couchpotato::movies_dir'] == $movies_dir {
    file { $movies_dir:
      ensure => 'directory';
    }
  }

  if couchpotato::params({}, Puppet::LookupContext.new('m'))['couchpotato::downloads_dir'] == $downloads_dir {
    file { $downloads_dir:
      ensure => 'directory';
    }
  }

  docker::run { 'couchpotato':
    image         => 'linuxserver/couchpotato',
    ports         => [
      '5050:5050/tcp',
    ],
    volumes       => [
      "${base_dir}:/config",
      "${movies_dir}:/movies",
      "${downloads_dir}:/downloads",
    ],
    env           => [
      'PLEX_UID=0',
      'PLEX_GID=0',
    ],
    pull_on_start => true,
    require       => [
      File[$base_dir],
      File[$movies_dir],
      File[$downloads_dir],
    ]
  }

}
