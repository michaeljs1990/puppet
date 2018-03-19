class devnode {

  Class[mounts::media] -> Class[sickrage]
  Class[mounts::backup] -> Class[sickrage]

  Class[mounts::media] -> Class[plex]
  Class[mounts::backup] -> Class[plex]

  Class[mounts::media] -> Class[couchpotato]
  Class[mounts::backup] -> Class[couchpotato]

  # testing out plex for now
  include mounts::media
  include mounts::backup

  include plex
  include sickrage
  include couchpotato

}
