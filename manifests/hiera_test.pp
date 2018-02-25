# /etc/puppetlabs/code/environments/production/modules/profile/manifests/hiera_test.pp
class profile::hiera_test (
  Boolean             $ssl,
  Boolean             $backups_enabled,
  Optional[String[1]] $site_alias = undef,
  Optional[String[1]] $nodeclass = undef,
  Optional[String[1]] $pool = undef,
  Optional[String[1]] $site = undef,
) {
  file { '/tmp/hiera_test.txt':
    ensure  => file,
    content => @("END"),
               Data from profile::hiera_test
               -----
               profile::hiera_test::ssl: ${ssl}
               profile::hiera_test::backups_enabled: ${backups_enabled}
               profile::hiera_test::site_alias: ${site_alias}
               profile::hiera_test::nodeclass: ${nodeclass}
               profile::hiera_test::pool: ${pool}
               profile::hiera_test::site: ${site}
               |END
    owner   => root,
    mode    => '0644',
  }
}
