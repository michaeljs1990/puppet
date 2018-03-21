# Start nginx proxy to sickrage

class sickrage::nginx() {

  include nginx

  $upstream = 'sickrage_upstream'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:8080',
    ],
  }

  nginx::resource::server {
    'sickrage.terame.com':
      proxy => "http://${upstream}";
    'sickrage.terame.m':
      proxy => "http://${upstream}";
  }

}
