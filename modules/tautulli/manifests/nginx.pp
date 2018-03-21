# Start nginx proxy to tautulli

class tautulli::nginx() {

  require inginx::htpasswd
  include nginx

  $upstream = 'tautulli_upstream'
  $failed_msg = 'welcome to the no spin zone.'
  $user_file = '/etc/nginx/.htpasswd'

  nginx::resource::upstream { $upstream:
    members => [
      'localhost:8181',
    ],
  }

  nginx::resource::server {
    'tautulli.terame.com':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
    'tautulli.terame.m':
      proxy                => "http://${upstream}",
      auth_basic           => $failed_msg,
      auth_basic_user_file => $user_file;
  }

}
