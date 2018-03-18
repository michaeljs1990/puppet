# Ensure the proper nameserver is set

class resolv (
  Array $nameservers
) {

  file { '/etc/resolv.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('resolv/resolv.conf.erb'),
  }

}
