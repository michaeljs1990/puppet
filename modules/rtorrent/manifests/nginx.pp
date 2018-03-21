# Start nginx proxy to rtorrent

class rtorrent::nginx() {

  include nginx

  $upstream = 'rtorrent_upstream'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:3000',
    ],
  }
  
  # the trans sub domain is here for legacy support
  nginx::resource::server { 
    'trans.terame.com':
      proxy => "http://$upstream";
    'trans.terame.m':
      proxy => "http://$upstream";
    'rtorrent.terame.com':
      proxy => "http://$upstream";
    'rtorrent.terame.m':
      proxy => "http://$upstream";
  } 

}
