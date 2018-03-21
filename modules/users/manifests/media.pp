# This user is purely to make the nfs server more pretty to look at
# it serves no functional purpose.

class users::media {

  group { 'media':
    ensure => 'present',
    gid    => '10000',
  }

  user { 'media':
    ensure => 'present',
    gid    => '10000',
    uid    => '10000',
  }
}
