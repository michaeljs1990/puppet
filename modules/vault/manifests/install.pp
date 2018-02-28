class vault::install (
  String $init_system,
  String $source_tar,
  String $path
) {

  include staging
  
  $output_tar = 'consul-template.tar.gz'

  staging::file { $output_tar:
    source => $source_tar
  }

  staging::extract { $output_tar:
    target  => "${staging::path}",
    creates => "${staging::path}/consul-template",
    require => Staging::File['consul-template.tar.gz'],
  }
}
