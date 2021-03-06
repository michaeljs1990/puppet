# Start nginx proxy to rtorrent

class rtorrent::nginx() {

  require inginx::htpasswd
  include nginx

  $upstream = 'rtorrent_upstream'
  $failed_msg = 'welcome to the no spin zone.'
  $user_file = '/etc/nginx/.htpasswd'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:3000',
    ],
  }

  # the trans sub domain is here for legacy support
  nginx::resource::server {
    'trans.terame.com':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
    'trans.terame.m':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
    'rtorrent.terame.com':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
    'rtorrent.terame.m':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
  }

}
