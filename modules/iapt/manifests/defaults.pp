# Install default apt repos that should be on every server

class iapt::defaults {

  apt::source { 'xenial-updates-universe':
    comment  => 'Default Package',
    location => 'http://us.archive.ubuntu.com/ubuntu',
    release  => 'xenial-updates',
    repos    => 'universe',
    notify   => Exec['apt_update']
  }

}
