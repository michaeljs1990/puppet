# install consul-template

class vault::install (
  String $init_system,
  String $source_tar,
  String $path
) {

  include staging
  include ::systemd::systemctl::daemon_reload

  $output_tar = 'consul-template.tar.gz'

  staging::file { $output_tar:
    source => $source_tar
  }
  -> staging::extract { $output_tar:
    target  => $staging::path,
    creates => "${staging::path}/consul-template"
  }
  -> file { "${path}/consul-template":
    ensure => present,
    mode   => '0755',
    source => "${staging::path}/consul-template"
  }
  -> file { '/etc/systemd/system/consul-template.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/vault/consul-template.service',
  } ~> Class['systemd::systemctl::daemon_reload']

  service {'consul-template':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    restart    => 'service consul-template restart',
    start      => 'service consul-template start',
    stop       => 'service consul-template stop',
    subscribe  => [
      File['/etc/systemd/system/consul-template.service'],
      File['/etc/consul-template/config.hcl']
    ],
  }

}
