function vault::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_params = {
    'vault::pid_file' => '/var/run/consul-template.pid',
    'vault::address' => 'http://127.0.0.1:8200',
    'vault::token' => '',
    'vault::templates' => [{
      'template_file' => '',
      'destination_file' => ''
    }],
    'vault::init_system' => 'systemd',
    'vault::source_tar'  => 'https://releases.hashicorp.com/consul-template/0.19.4/consul-template_0.19.4_linux_amd64.tgz',
    'vault::path' => '/usr/bin'
  }

}
