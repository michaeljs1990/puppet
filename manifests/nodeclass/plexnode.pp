class plexnode {

  # testing out plex for now
  require mounts::tmp
  require mounts::media

  # give a name to the 10000 id
  include users::media

  include plex
  include sickrage
  include rtorrent
  include tautulli
  include couchpotato

}
