# Pull down and configure docker version of sickrage

class sickrage::install (
  String $base_dir,
  String $config_dir,
  String $downloads_dir,
  String $tv_dir,
) {

  require idocker

  if sickrage::params({}, Puppet::LookupContext.new('m'))['sickrage::base_dir'] == $base_dir {
    file { $base_dir:
      ensure => 'directory';
    }
  }

  if sickrage::params({}, Puppet::LookupContext.new('m'))['sickrage::config_dir'] == $config_dir {
    file { $config_dir:
      ensure => 'directory';
    }
  }

  if sickrage::params({}, Puppet::LookupContext.new('m'))['sickrage::downloads_dir'] == $downloads_dir {
    file { $downloads_dir:
      ensure => 'directory';
    }
  }

  if sickrage::params({}, Puppet::LookupContext.new('m'))['sickrage::tv_dir'] == $tv_dir {
    file { $tv_dir:
      ensure => 'directory';
    }
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
