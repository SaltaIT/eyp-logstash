# logstash

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with logstash](#setup)
    * [What logstash affects](#what-logstash-affects)
    * [Beginning with logstash](#beginning-with-logstash)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

logstash management

## Module Description

This module is intended for a ELK setup

## Setup

### What logstash affects

* Package management
* Input and output plugins
* Service management

### Beginning with logstash

```puppet
class { 'logstash': }

logstash::input::tcp { 'tcp-1234':
  port => '1234',
}

logstash::input::beats { 'beats': }

logstash::input::syslog { 'syslog': }

logstash::input::redis { 'redis': }

logstash::input::file { 'files':
  paths => [ '/var/log/messages', '/var/log/syslog' ],
}

logstash::output::elasticsearch { 'elasticsearch': }

logstash::customconf { 'demo':
  content => "# test\n",
}
```

## Usage

### Import a manually managed configuration file

```puppet
logstash::customconf { 'demo':
  content => 
}
```

## Reference

### classes

#### logstash

### resources

#### logstash::input::tcp

#### logstash::input::beats

#### logstash::input::syslog

#### logstash::input::redis

#### logstash::input::file

#### logstash::output::elasticsearch

#### logstash::customconf


## Limitations

RHEL 7 and derivatives only

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
