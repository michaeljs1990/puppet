class plex(
  Boolean $ramdisk
) {

  require plex::install
  
  service{ 'plexmediaserver':
    ensure => 'running',
    enable => true
  }

  if $ramdisk {
    warning('Coming Soon...')
  }

}
