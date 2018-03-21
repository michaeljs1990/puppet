# Start nginx proxy to couchpotato

class couchpotato::nginx() {

  require inginx::htpasswd
  include nginx

  $upstream = 'couchpotato_upstream'
  $failed_msg = 'welcome to the no spin zone.'
  $user_file = '/etc/nginx/.htpasswd'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:5050',
    ],
  }

  nginx::resource::server {
    'couchpotato.terame.com':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
    'couchpotato.terame.m':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
  }

}
