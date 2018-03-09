# See https://github.com/pypa/pipenv which I extracted
# the keys from for this class.

class python::pipenv {

  apt::source { 'pypa':
    comment  => 'Python Pypa PPA for pipenv',
    location => 'http://ppa.launchpad.net/pypa/ppa/ubuntu',
    release  => 'devel',
    repos    => 'main',
    key      => '99624F96E68C4B80F1A58572539EE1903B50BB75',
    notify   => Exec['apt_update']
  } ->

  package { 'pipenv':
    ensure => 'installed'
  }

}
