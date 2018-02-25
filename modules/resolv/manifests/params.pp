function resolv::params(
  Hash                  $options,
  Puppet::LookupContext $context,
) {

  $base_params = {
    'resolv::nameservers' => ['8.8.4.4'],
  }

}
