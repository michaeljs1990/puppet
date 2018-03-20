# Backup NFS Server

class mounts::backup {

  include mounts::nfs

  file { '/mnt/backup':
    ensure => 'directory',
  }

  mount { '/mnt/backup':
    ensure  => 'mounted',
    fstype  => 'nfs',
    device  => '192.168.2.3:/shares/backup',
    options => 'auto,noatime,nolock,bg,nfsvers=4,intr,tcp,actimeo=1800',
    atboot  => true,
    require => [
      File['/mnt/backup'],
      Package['nfs-common']
    ],
  }

}
