class vault::consul_template() {

  class { 'consul_template':
    service_enable   => false,
    config_hash      => {
      log_level => 'debug',
      wait      => '5s:30s',
      max_stale => '1s'
    }
  }

}
