# truthcon

A companion of my blog [Puppet Truth Value: Meet Tuple][1], this module
explores a quirk in using Puppet's automatic conversion to Boolean.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with truthcon](#setup)
    * [What truthcon affects](#what-truthcon-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with truthcon](#beginning-with-truthcon)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Puppet's automatic conversion is convenient.  But this can cause problems when
passing an untyped expression to a class with typed parameters.

Play with truthcon_spec.rb and observe the failed examples to diagnose one such
use cases.  Alternatively, invoke this module with various parameters.

## Setup

### What truthcon affects

Truthcon (and truthcon::booleans) prints out some messages and changes nothing.

### Setup Requirements

This is a self-contained module that is not intended to be included by any
practical code.  No setup required.

However, you can take advantage of PDK to quickly triage and diagnose.  For
this, you need to install PDK.  The provided templates are tested in PDK 2.7.1.

### Beginning with truthcon

You can test the effects by invoking truthcon with or without parameters, e.g.,
```
  include truthcon
```

## Usage

- Invoking truthcon without parameter should not cause error.

- Matching $merex2 alone should not cause error.  For example,
  ```
  class { 'truthcon':
    $merex1 => /not a chance|nowayjose/,
    $merex2 => /test|more|testing/,
  }
  ```
  This should give you some output about variable values and matches, but the class should succeed.

- Any time $merex1 has a match, Puppet will give you an error
  ```
  "Class[Truthcon::Booleans]: parameter 'condition1' expects a Boolean value, got Tuple"
  ```
  For example,
  ```
  class { 'truthcon':
    metext => 'not a chance',
    merex1 => /not a chance|nowayjose/,
  }
  ```

Alternatively, play with truthcon_spec.rb if you have PDK installed.  For example,
```
pdk test unit
```

## Limitations

Some unit tests in truthcon_spec.rb are designed to fail.

## Development

Play along.  Suggestions about how to increase instructional value welcome.

## References

[1]: https://whackyhack.wordpress.com/2023/06/22/puppet-truth-value-meet-tuple/
