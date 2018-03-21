# Setup an ntpasswd file for simple authentication lock down

class inginx::htpasswd (
  String $file,
  String $password_hash,
) {

  $user = 'media'

  file { $file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('inginx/htpasswd.erb'),
  }

}
