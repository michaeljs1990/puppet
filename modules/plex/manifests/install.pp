# Install plex using docker instead of using a system wide install. This has several nice
# advantages. If you ever want to change around paths on disks the plex config is protected
# since it will always map to /data/tvshows or /data/movies in the container. Additionally
# it keeps the machine looking nice and clean.

class plex::install(
  String $base_dir,
  String $movies_dir,
  String $tvshows_dir,
  String $transcode_dir,
) {

  require idocker

  if plex::params({}, Puppet::LookupContext.new('m'))['plex::base_dir'] == $base_dir {
    file { $base_dir:
      ensure => 'directory';
    }
  }

  if plex::params({}, Puppet::LookupContext.new('m'))['plex::movies_dir'] == $movies_dir {
    file { $movies_dir:
      ensure => 'directory';
    }
  }

  if plex::params({}, Puppet::LookupContext.new('m'))['plex::tvshows_dir'] == $tvshows_dir {
    file { $tvshows_dir:
      ensure => 'directory';
    }
  }

  if plex::params({}, Puppet::LookupContext.new('m'))['plex::transcode_dir'] == $transcode_dir {
    file { $transcode_dir:
      ensure => 'directory';
    }
  }

  docker::run { 'plex':
    image         => 'linuxserver/plex',
    ports         => [
      '32400:32400',
      '32469:32469',
      '32400:32400/udp',
      '32469:32469/udp',
      '5353:5353/udp',
      '1900:1900/udp',
    ],
    volumes       => [
      "${base_dir}:/config",
      "${movies_dir}:/data/movies",
      "${transcode_dir}:/transcode",
      "${tvshows_dir}:/data/tvshows",
    ],
    env           => [
      'PGID=0',
      'PUID=0',
    ],
    pull_on_start => true,
    require       => [
      File[$base_dir],
      File[$movies_dir],
      File[$tvshows_dir],
      File[$transcode_dir],
    ]
  }

}
