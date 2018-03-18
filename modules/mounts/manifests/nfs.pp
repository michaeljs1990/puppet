# Just install nfs for right now

class mounts::nfs {

  package { 'nfs-common':
    ensure => 'installed',
  }

}
