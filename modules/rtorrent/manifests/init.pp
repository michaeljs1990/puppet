class rtorrent (
  String $config_dir,
  String $downloads_dir,
) {

  class { 'rtorrent::install':
    config_dir    => $config_dir,
    downloads_dir => $downloads_dir,
  }

}
