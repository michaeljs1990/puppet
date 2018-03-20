# Run rtorrent in docker. I was just going to keep it simple and use
# the system installed rtorrent but it doesn't come with any kind of
# upstart/systemd script to keep it running so it's easier to do this.

class rtorrent::install (
  String $config_dir,
  String $downloads_dir,
) {

  if rtorrent::params({}, Puppet::LookupContext.new('m'))['rtorrent::config_dir'] == $config_dir {
    file { $config_dir:
      ensure => 'directory';
    }
  }

  if rtorrent::params({}, Puppet::LookupContext.new('m'))['rtorrent::downloads_dir'] == $downloads_dir {
    file { $downloads_dir:
      ensure => 'directory';
    }
  }

  docker::run { 'rtorrent':
    image         => 'linuxserver/rutorrent',
    ports         => [
      '3000:80/tcp',
      '5000:5000/tcp',
      '6881:6881/udp',
      '51413:51413/tcp',
    ],
    volumes       => [
      "${config_dir}:/config",
      "${downloads_dir}:/downloads",
    ],
    env           => [
      'TERM=xterm',  # Hack or rtorrent fails to start without this set
      'PGID=10000',
      'PUID=10000',
    ],
    pull_on_start => true,
    require       => [
      File[$config_dir],
      File[$downloads_dir],
    ]
  }

}
