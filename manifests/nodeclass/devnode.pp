class devnode {

  # testing out plex for now
  include mounts::media
  include mounts::backup

  include plex
  include sickrage

}
