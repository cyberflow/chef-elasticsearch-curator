# CHANGELOG
## 0.2.8
* Fix user permissions for curator config file (contributed by @codylewandowski)
* Change serverspec tests to inspec
* Add inspec verifier to kitchen.yml

## 0.2.7
* Sets tricter permissions on the curator config (contributed by @kovyrin)

## 0.2.6
* fix issue #10

## 0.2.5
* Added support for centos 6 (contributed by @mdarii)

* Change syntax test to `cookstyle`

* Added LICENSE file

## 0.2.4
* Set conditional repo_url attributes directly in default attributes files instead of inside the resource as @Cyberflow recommended (contributed by @GHostQC)

* Fixed coding style according to Rubocop tests as @Cyberflow recommanded (contributed by @GHostQC)

* Set max blocklength to 50 instead 30 (contributed by @GHostQC)

## 0.2.3
* Fixed pip-installation on both ubuntu and centos boxes, ServerSpec test now verify successfully (contributed by @GHostQC)

## 0.2.2
* Added ServerSpec test suites (contributed by @GHostQC)

## 0.2.1
* Patched resource config.rb attributes http_auth to allow nil as a value as it is now deprecated (contributed by @GHostQC)

## 0.2.0
* Added support for rhel platform family compatible with YUM; Tested on CentOS 7.2 (contributed by @GHostQC)

## 0.1.5
* Change package name for elasticsearch-curator debian package version from 4.2

## 0.1.4
* Supports a http_auth property (contributed by @EmFl)

## 0.1.3
* Add elasticsearch-curator bin path to resource and attributes

## 0.1.2
* Bug fixed
* Add test cookbook for kitchen tests

## 0.1.1
* add compatibility with 12.X versions of Chef
