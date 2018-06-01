# tmp NFS Server this holds stuff like downloads that will
# quickly be moved to other locations.

class mounts::tmp {

  include mounts::nfs

  file { '/mnt/tmp':
    ensure => 'directory',
  }

  mount { '/mnt/tmp':
    ensure  => 'mounted',
    fstype  => 'nfs',
    device  => '10.0.0.12:/shares/tmp',
    options => 'auto,noatime,bg,nfsvers=4,intr,tcp',
    atboot  => true,
    require => [
      File['/mnt/tmp'],
      Package['nfs-common']
    ],
  }
  -> file {
    '/mnt/tmp/downloads':
      ensure => directory;
  }

}
