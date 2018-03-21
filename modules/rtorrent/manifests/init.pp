class rtorrent (
  String $config_dir,
  String $downloads_dir,
) {

  include rtorrent::nginx

  class { 'rtorrent::install':
    config_dir    => $config_dir,
    downloads_dir => $downloads_dir,
  }

}
