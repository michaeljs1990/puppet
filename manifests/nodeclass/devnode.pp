class devnode {

  # testing out plex for now
  require mounts::tmp
  require mounts::media
  require mounts::backup

  # give a name to the 10000 id
  include users::media

  include plex
  include sickrage
  include rtorrent
  include tautulli
  include couchpotato

}
