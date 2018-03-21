# Start nginx proxy to plex

class plex::nginx() {

  include nginx

  $upstream = 'plex_upstream'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:32400',
    ],
  }

  nginx::resource::server {
    'plex.terame.com':
      proxy => "http://${upstream}";
    'plex.terame.m':
      proxy => "http://${upstream}";
  }

}
