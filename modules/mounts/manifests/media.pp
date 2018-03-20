# Media server for TV and Movies only

class mounts::media {

  include mounts::nfs

  file { '/mnt/media':
    ensure => 'directory',
  }

  mount { '/mnt/media':
    ensure  => 'mounted',
    fstype  => 'nfs',
    device  => '192.168.2.3:/shares/media',
    options => 'auto,noatime,nolock,bg,nfsvers=4,intr,tcp,actimeo=1800',
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
