Vagrant Masonry - Config Builder
======================

[![Gem Version](https://img.shields.io/gem/v/vagrant-masonry.svg)](http://rubygems.org/gems/vagrant-masonry)
[![License](http://img.shields.io/badge/license-Apache_2.0-373737.svg)](http://rubygems.org/gems/vagrant-masonry/blob/master/LICENSE)


Configure and manage your Vagrant environments using structured data.

> Masonry is the craft of shaping rough pieces of rock into accurate geometrical shapes, at times simple, but some of considerable complexity, and then arranging the resulting stones to form structures.

Synopsis
--------

This plugin provides an interface to the Vagrant configuration constructs in a
logic free manner. You can format your input data to fit your needs and use
`vagrant-masonry` to transform that into the needed Vagrant config.

Example
-------

This example loads all yaml files in the config directory and generates a
Vagrant config based on that information. File names are arbitrary and chosen
for clarity.

#### Directory structure

```shell
.
├── config
│   ├── roles.yaml
│   └── vms.yaml
└── Vagrantfile
```

#### Vagrantfile

For pure yaml configurations, use yaml loader:
```ruby
require 'masonry'
Vagrant.configure('2', &ConfigBuilder.load(
  :yaml,
  :yamldir,
  File.expand_path('../config', __FILE__)
))
```

For yaml erb configurations, use yaml_erb loader:
```ruby
require 'masonry'
Vagrant.configure('2', &ConfigBuilder.load(
  :yaml_erb,
  :yamldir,
  File.expand_path('../config', __FILE__)
))
```

The yaml_erb loader would allow configuration such as:
```yaml
---
roles:
  puppet_apply:
    provisioners:
      - type: puppet
        manifests_path: 'tests'
        module_path: 'spec/fixtures/modules'
        manifest_file: <%= ENV['VAGRANT_MANIFEST'] || 'init.pp' %>
```

#### config/roles.yaml

```yaml
---
boxes:
  centos-65-x64: http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box
  debian-73-x64: http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-puppet.box
roles:
  bigvm:
    provider:
      type: virtualbox
      customize: [[modifyvm, !ruby/sym id, '--memory', 1024]]
    synced_folders:
      - host_path: '.'
        guest_path: '/vagrant'
        disabled: true
  smallvm:
    provider:
      type: vmware
      vmx:
        memsize: 512
        numvcpus: 1
```

#### config/vms.yaml

```yaml
---
vms:
  -
    name: db
    private_networks: [ {ip: '10.20.1.2'} ]
    box: centos-65-x64
    hostname: db.puppetlabs.vm
    roles: bigvm
  -
    name: web
    private_networks: [ {ip: '10.20.1.3'} ]
    box: debian-73-x64
```

Installation
------------

### Installation into the Vagrant internal gems:

  * `vagrant plugin install vagrant-masonry`

### Installation from source

Build the gem:

  * `gem build vagrant-masonry.gemspec`

Install the gem:

  * `gem install vagrant-masonry-<version>.gem`

License
-------

**Vagrant Masonry** plugin is based on [vagrant-config_builder](https://github.com/adrienthebo/vagrant-config_builder) plugin.

**Vagrant Masonry** is licensed under [Apache 2.0](LICENSE) license.
