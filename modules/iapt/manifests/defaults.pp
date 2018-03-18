# Install default apt repos that should be on every server

class iapt::defaults {

  apt::source { 'bionic-universe':
    comment  => 'Default Package',
    location => 'http://us.archive.ubuntu.com/ubuntu',
    release  => 'bionic',
    repos    => 'universe',
    notify   => Exec['apt_update']
  }

}
