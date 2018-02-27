# puppet-consul
[![Build Status](https://travis-ci.org/solarkennedy/puppet-consul.png)](https://travis-ci.org/solarkennedy/puppet-consul)
[![Puppet Forge](https://img.shields.io/puppetforge/e/KyleAnderson/consul.svg)](https://forge.puppetlabs.com/KyleAnderson/consul)
[![Puppet Forge](https://img.shields.io/puppetforge/v/KyleAnderson/consul.svg)](https://forge.puppetlabs.com/KyleAnderson/consul)
[![Puppet Forge](https://img.shields.io/puppetforge/f/KyleAnderson/consul.svg)](https://forge.puppetlabs.com/KyleAnderson/consul)

## Compatibility

**WARNING**: Backwards incompatible changes happen in order to more easily support
new versions of consul. Pin to the version that works for your setup!

| Consul Version   | Recommended Puppet Module Version   |
| ---------------- | ----------------------------------- |
| >= 0.9.0         | latest                              |
| 0.8.x            | <= 3.2.4                            |
| 0.7.0            | <= 2.1.1                            |
| 0.6.0            | <= 2.1.1                            |
| 0.5.x            | 1.0.3                               |
| 0.4.x            | 0.4.6                               |

### What This Module Affects

* Installs the consul daemon (via url or package)
  * If installing from zip, you *must* ensure the unzip utility is available.
  * If installing from docker, you *must* ensure puppetlabs-docker_platform module is available.
* Optionally installs a user to run it under
* Installs a configuration file (/etc/consul/config.json)
* Manages the consul service via upstart, sysv, systemd, or nssm.
* Optionally installs the Web UI

## Usage

To set up a single consul server, with several agents attached:
On the server:
```puppet
class { '::consul':
  config_hash => {
    'bootstrap_expect' => 1,
    'data_dir'         => '/opt/consul',
    'datacenter'       => 'east-aws',
    'log_level'        => 'INFO',
    'node_name'        => 'server',
    'server'           => true,
  }
}
```
On the agent(s):
```puppet
class { '::consul':
  config_hash => {
    'data_dir'   => '/opt/consul',
    'datacenter' => 'east-aws',
    'log_level'  => 'INFO',
    'node_name'  => 'agent',
    'retry_join' => ['172.16.0.1'],
  }
}
```
Disable install and service components:
```puppet
class { '::consul':
  install_method => 'none',
  init_style     => false,
  manage_service => false,
  config_hash => {
    'data_dir'   => '/opt/consul',
    'datacenter' => 'east-aws',
    'log_level'  => 'INFO',
    'node_name'  => 'agent',
    'retry_join' => ['172.16.0.1'],
  }
}
```

## Web UI

To install and run the Web UI on the server, include `ui => true` in the
`config_hash`. You may also want to change the `client_addr` to `0.0.0.0` from
the default `127.0.0.1`, for example:
```puppet
class { '::consul':
  config_hash => {
    'bootstrap_expect' => 1,
    'client_addr'      => '0.0.0.0',
    'data_dir'         => '/opt/consul',
    'datacenter'       => 'east-aws',
    'log_level'        => 'INFO',
    'node_name'        => 'server',
    'server'           => true,
    'ui'               => true,
  }
}
```
For more security options, consider leaving the `client_addr` set to `127.0.0.1`
and use with a reverse proxy:
```puppet
$aliases = ['consul', 'consul.example.com']

# Reverse proxy for Web interface
include 'nginx'

$server_names = [$::fqdn, $aliases]

nginx::resource::vhost { $::fqdn:
  proxy       => 'http://localhost:8500',
  server_name => $server_names,
}
```

## Service Definition

To declare the availability of a service, you can use the `service` define. This
will register the service through the local consul client agent and optionally
configure a health check to monitor its availability.

```puppet
::consul::service { 'redis':
  checks  => [
    {
      script   => '/usr/local/bin/check_redis.py',
      interval => '10s'
    }
  ],
  port    => 6379,
  tags    => ['master']
}
```

See the service.pp docstrings for all available inputs.

You can also use `consul::services` which accepts a hash of services, and makes
it easy to declare in hiera. For example:

```puppet
consul::services:
  service1:
    address: "%{::ipaddress}"
    checks:
      - http: http://localhost:42/status
        interval: 5s
    port: 42
    tags:
      - "foo:%{::bar}"
  service2:
    address: "%{::ipaddress}"
    checks:
      - http: http://localhost:43/status
        interval: 5s
    port: 43
    tags:
      - "foo:%{::baz}"
```

## Watch Definitions

```puppet
::consul::watch { 'my_watch':
  handler     => 'handler_path',
  passingonly => true,
  service     => 'serviceName',
  service_tag => 'serviceTagName',
  type        => 'service',
}
```

See the watch.pp docstrings for all available inputs.

You can also use `consul::watches` which accepts a hash of watches, and makes
it easy to declare in hiera.

## Check Definitions

```puppet
::consul::check { 'true_check':
  interval => '30s',
  script   => '/bin/true',
}
```

See the check.pp docstrings for all available inputs.

You can also use `consul::checks` which accepts a hash of checks, and makes
it easy to declare in hiera.

## Removing Service, Check and Watch definitions

Do `ensure => absent` while removing existing service, check and watch
definitions. This ensures consul will be reloaded via `SIGHUP`. If you have
`purge_config_dir` set to `true` and simply remove the definition it will cause
consul to restart.

## ACL Definitions

```puppet
consul_acl { 'ctoken':
  ensure => 'present',
  rules  => {'key' => {'test' => {'policy' => 'read'}}},
  type   => 'client',
}
```

Do not use duplicate names, and remember that the ACL ID (a read-only property for this type)
is used as the token for requests, not the name

Optionally, you may supply an `acl_api_token`.  This will allow you to create
ACLs if the anonymous token doesn't permit ACL changes (which is likely).
The api token may be the master token, another management token, or any
client token with sufficient privileges.

**NOTE:** This module currently cannot parse ACL tokens generated through means
other than this module. Don't mix Puppet and Non-puppet ACLs for best results!
(pull requests welcome to allow it to co-exist with ACLs generated with normal HCL)

## Prepared Queries and Prepared Query Templates

```puppet
consul_prepared_query { 'consul':
  ensure               => 'present',
  service_name         => 'consul',
  service_failover_n   => 1,
  service_failover_dcs => [ 'dc1', 'dc2' ],
  service_only_passing => true,
  service_tags         => [ 'tag1', 'tag2' ],
  ttl                  => 10,
}
```

or a prepared query template:

```puppet
consul_prepared_query { 'consul':
  ensure               => 'present',
  service_name         => 'consul',
  service_name         => 'consul-${match(1)}' # lint:ignore:single_quote_string_with_variables
  service_failover_n   => 1,
  service_failover_dcs => [ 'dc1', 'dc2' ],
  service_only_passing => true,
  service_tags         => [ '${match(2)}' ], # lint:ignore:single_quote_string_with_variables
  template             => true,
  template_regexp      => '^consul-(.*)-(.*)$',
  template_type        => 'name_prefix_match',
}
```

## Key/Value Objects

Example:

```puppet
consul_key_value { 'key/path':
  ensure     => 'present',
  value      => 'myvaluestring',
  flags      => 12345,
  datacenter => 'dc1'
}
```

This provider allows you to manage key/value pairs. It tries to be smart in two ways:

1. It caches the data accessible from the kv store with the specified acl token.
2. It does not update the key if the value & flag are already correct.


These parameters are mandatory when using `consul_key_value`:

* `name` Name of the key/value object. Path in key/value store.
* `value` value of the key. 

The optional parameters only need to be specified if you require changes from default behaviour.

* `flags` {Integer} an opaque unsigned integer that can be attached to each entry. Clients can choose to use this however makes sense for their application. Default is `0`.
* `acl\_api_token` {String} Token for accessing the ACL API. Default is `''`.
* `datacenter` {String} Use the key/value store in specified datacenter. If `''` (default) it will use the datacenter of the Consul agent at the HTTP address.
* `protocol` {String} protocol to use. Either `'http'` (default) or `'https'`.
* `port` {Integer} consul port. Defaults to `8500`.
* `hostname` {String} consul hostname. Defaults to `'localhost'`.
* `api_tries` {Integer} number of tries when contacting the Consul REST API. Timeouts are not retried because a timeout already takes long. Defaults to `3`.

## Limitations

Depends on the JSON gem, or a modern ruby. (Ruby 1.8.7 is not officially supported)
Depending on the version of puppetserver deployed it may not be new enough (1.8.0 is too old, 2.0.3 is known to work).

## Windows Experimental Support

Windows service support is provided by [NSSM](https://nssm.cc), which is expected to be installed separately. The following caveats apply:

 * The user and group parameter must be different (Administrator/Administrators recommended).
 * The NSSM executable must be passed as a parameter like in the following example:

```puppet
class { '::consul':
  nssm_exec   => 'C:/Program Files/nssm/nssm-2.24/win64/nssm.exe',
  bin_dir     => 'C:/Consul',
  user        => 'Administrator',
  group       => 'Administrators',
  config_hash => {
    'bootstrap_expect' => 1,
    'data_dir'         => 'C:/Consul',
    'datacenter'       => 'dc1',
    'log_level'        => 'INFO',
    'node_name'        => 'server',
    'server'           => true,
  }
}
```

## Consul Template

[Consul Template](https://github.com/hashicorp/consul-template) is a piece of
software to dynamically write out config files using templates that are populated
with values from Consul. This module does not configure consul template. See
[gdhbashton/consul_template](https://github.com/gdhbashton/puppet-consul_template) for
a module that can do that.

## Development
Open an [issue](https://github.com/solarkennedy/puppet-consul/issues) or
[fork](https://github.com/solarkennedy/puppet-consul/fork) and open a
[Pull Request](https://github.com/solarkennedy/puppet-consul/pulls)
