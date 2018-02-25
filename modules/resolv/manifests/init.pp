class resolv (
  Array $nameservers = $resolv::params::nameserver
) {

  file { '/etc/resolv.conf':
   ensure  => file,
   owner   => 'root',
   group   => 'root',
   mode    => '0644',
   content => template('resolv/resolv.conf.erb'),
  } 

}
