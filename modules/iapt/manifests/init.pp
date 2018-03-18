# Install default apt repos that should be on every server

class iapt(
  String $release
) {

  apt::source { "${release}-universe":
    comment  => 'universal packages',
    location => 'http://us.archive.ubuntu.com/ubuntu',
    release  => $release,
    repos    => 'universe',
    notify   => Exec['apt_update']
  }

}
