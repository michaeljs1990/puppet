# Start nginx proxy to couchpotato

class couchpotato::nginx() {

  include nginx

  $upstream = 'couchpotato_upstream'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:5050',
    ],
  }

  nginx::resource::server {
    'couchpotato.terame.com':
      proxy => "http://${upstream}";
    'couchpotato.terame.m':
      proxy => "http://${upstream}";
  }

}
