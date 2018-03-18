class mounts::media {

  include mounts::nfs

  file { "/mnt/media":
    ensure => 'directory',
  }

  mount { "/mnt/media":
    device  => "192.168.2.3:/shares/media",
    fstype  => "nfs",
    ensure  => "mounted",
    options => "defaults",
    atboot  => true,
    require => [
      File["/mnt/media"],
      Package['nfs-common']
    ],
  }

}
