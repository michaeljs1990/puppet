# Setup the apt repo shown at the following URL
# https://support.plex.tv/articles/235974187-enable-repository-updating-for-supported-linux-server-distributions/

class plex::install() {

  apt::source { 'plexmedia':
    comment  => 'Plex Media',
    location => 'http://downloads.plex.tv/repo/deb',
    release  => 'public',
    repos    => 'main',
    key      => 'CD665CBA0E2F88B7373F7CB997203C7B3ADCA79D',
    notify   => Exec['apt_update']
  } ->

  package { 'plexmediaserver':
    ensure => 'installed'
  }

}
