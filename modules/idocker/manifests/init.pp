# Just use the default docker install for now. However always
# include it via the idocker class so that if we need to change
# things around later it's all in one place.

class idocker(
  String $release
) {

  Class[iapt::defaults] -> Class[docker]

  class { 'docker':
    docker_ce_release => $release 
  }

}
