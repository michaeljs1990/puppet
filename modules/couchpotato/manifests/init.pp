class couchpotato (
  String $base_dir,
  String $movies_dir,
  String $downloads_dir,
) {

  include couchpotato::nginx

  class { 'couchpotato::install':
    base_dir      => $base_dir,
    movies_dir    => $movies_dir,
    downloads_dir => $downloads_dir,
  }

}
