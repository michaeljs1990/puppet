# Start nginx proxy to tautulli

class tautulli::nginx() {

  include nginx

  $upstream = 'tautulli_upstream'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:8181',
    ],
  }
  
  nginx::resource::server { 
    'tautulli.terame.com':
      proxy => "http://$upstream";
    'tautulli.terame.m':
      proxy => "http://$upstream";
  } 

}
