class devnode {

  # testing out plex for now
  require mounts::media
  require mounts::backup

  include plex
  include sickrage
  include rtorrent
  include tautulli
  include couchpotato

}
