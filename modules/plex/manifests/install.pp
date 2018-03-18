# Install plex using docker instead of using a system wide install. This has several nice
# advantages. If you ever want to change around paths on disks the plex config is protected
# since it will always map to /data/tvshows or /data/movies in the container. Additionally
# it keeps the machine looking nice and clean.
#
# However plex sucks and offers no way to easily configure plex if it's not from local host.
# You will likely have to start the contianer in host networking to do the initial config.
# If you run the following command on your local computer and then go to 8080 you will be set
# as long as you uncomment the 'net' option in docker::run.
#
# ssh 10.0.0.101 -L 8080:localhost:32400 

class plex::install(
  String $base_dir,
  String $data_dir,
  String $transcode_dir,
) {

  require idocker

  if plex::params({}, Puppet::LookupContext.new('m'))['plex::base_dir'] == $base_dir {
    file { $base_dir:
      ensure => 'directory';
    }
  }

  if plex::params({}, Puppet::LookupContext.new('m'))['plex::data_dir'] == $data_dir {
    file { $data_dir:
      ensure => 'directory';
    }
  }

  if plex::params({}, Puppet::LookupContext.new('m'))['plex::transcode_dir'] == $transcode_dir {
    file { $transcode_dir:
      ensure => 'directory';
    }
  }

  docker::run { 'plex':
    image         => 'plexinc/pms-docker',
    # net           => "host",
    ports         => [
      '3005:3005/tcp',
      '8324:8324/tcp',
      '32400:32400/tcp',
      '32469:32469/tcp',
      '1900:1900/udp',
      '5353:5353/udp',
      '32400:32400/udp',
      '32410:32410/udp',
      '32412:32412/udp',
      '32413:32413/udp',
      '32414:32414/udp',
      '32469:32469/udp',
    ],
    volumes       => [
      "${base_dir}:/config",
      "${data_dir}:/data",
      "${transcode_dir}:/transcode",
    ],
    env           => [
      'PLEX_UID=0',
      'PLEX_GID=0',
      "HOSTNAME=${::fqdn}",
      "ADVERTISE_IP=http://${::ipaddress}:32400",
    ],
    pull_on_start => true,
    require       => [
      File[$base_dir],
      File[$data_dir],
      File[$transcode_dir],
    ]
  }

}
