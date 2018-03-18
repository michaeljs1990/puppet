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
    options => 'defaults',
    atboot  => true,
    require => [
      File['/mnt/media'],
      Package['nfs-common']
    ],
  }

}
