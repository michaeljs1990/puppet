# Generate a config for use with consul_template currently
# I am only supporting using vault. Use the open source puppet
# code if you need support for consul.

class vault (
  String $pid_file,
  String $address,
  String $token,
  Array $templates,
  String $init_system,
  String $source_tar,
  String $path
) {

  class { 'vault::install':
    init_system => $init_system,
    source_tar  => $source_tar,
    path        => $path
  }

  file {
    '/etc/consul-template':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0600';
    '/etc/consul-template/config.hcl':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File['/etc/consul-template'],
      content => template('vault/template.hcl.erb');
  }

}
