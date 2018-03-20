class devnode {

  # testing out plex for now
  require mounts::tmp
  require mounts::media
  require mounts::backup

  include plex
  include sickrage
  include rtorrent
  include tautulli
  include couchpotato

}
