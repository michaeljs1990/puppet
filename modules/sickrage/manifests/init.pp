# Setup sickrage inside a docker container

class sickrage (
  String $base_dir,
  String $config_dir,
  String $downloads_dir,
  String $tv_dir,
) {

  include sickrage::nginx

  class { 'sickrage::install':
    base_dir      => $base_dir,
    config_dir    => $config_dir,
    downloads_dir => $downloads_dir,
    tv_dir        => $tv_dir,
  }

}
