# Media server for TV and Movies only

class mounts::media {

  include mounts::nfs

  file { '/mnt/media':
    ensure => 'directory',
  }

  mount { '/mnt/media':
    ensure  => 'mounted',
    fstype  => 'nfs',
    device  => '10.0.0.12:/shares/media',
    options => 'auto,noatime,bg,nfsvers=4,intr,tcp',
    atboot  => true,
    require => [
      File['/mnt/media'],
      Package['nfs-common']
    ],
  }
  -> file {
    '/mnt/media/Movies':
      ensure => 'directory';
    '/mnt/media/TV':
      ensure => 'directory';
  }

}
