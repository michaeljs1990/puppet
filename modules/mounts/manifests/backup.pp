class mounts::backup {

  include mounts::nfs

  file { "/mnt/backup":
    ensure => 'directory',
  }

  mount { "/mnt/backup":
    device  => "192.168.2.3:/shares/backup",
    fstype  => "nfs",
    ensure  => "mounted",
    options => "defaults",
    atboot  => true,
    require => [
      File["/mnt/backup"],
      Package['nfs-common']
    ],
  }

}
