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
  } ->

  staging::extract { $output_tar:
    target  => "${staging::path}",
    creates => "${staging::path}/consul-template"
  } ->
  
  file { "${path}/consul-template":
    ensure => present,
    mode => "755",
    source => "${staging::path}/consul-template"
  } ->

  file { '/etc/systemd/system/consul-template.service':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/vault/consul-template.service",
  } ~> Class['systemd::systemctl::daemon_reload']
  
  service {'consul-template':
    ensure    => 'running',
    subscribe => File['/etc/systemd/system/consul-template.service'],
  }
  
}
