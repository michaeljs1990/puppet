# Start nginx proxy to sickrage

class sickrage::nginx() {

  require inginx::htpasswd
  include nginx

  $upstream = 'sickrage_upstream'
  $failed_msg = 'welcome to the no spin zone.'
  $user_file = '/etc/nginx/.htpasswd'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:8080',
    ],
  }

  nginx::resource::server {
    'sickrage.terame.com':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
    'sickrage.terame.m':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
  }

}
