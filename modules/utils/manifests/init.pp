# Install general packages that are useful
# across multiple different nodeclasses.
class utils {

  $shared = [
    'vim',
    'python'
  ]

  package { $shared:
    ensure => installed
  }

}
