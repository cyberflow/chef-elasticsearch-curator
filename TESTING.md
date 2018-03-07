# Testing
## Prerequisites
We recommend to install [ChefDK] to your development environment.
It provides all tools used in the process of testig this cookbook.

## Integration
### Requirements
* [Vagrant]
* [VirtualBox] (other Vagrant provider may work but are not tested)

### Run Tests
To run all test suits on all platforms:
```shell
kitchen test
```

Instead of running all integration tests, you can specify each suite and platform to create the instances.
All steps can be run separately.
```
kitchen create default-ubuntu-1404
kitchen converge default-ubuntu-1404
kitchen setup default-ubuntu-1404
kitchen verify default-ubuntu-1404
kitchen destroy default-ubuntu-1404
```

List existing instances
```shell
kitchen list
```

## Lint
```shell
/opt/chefdk/bin/chef exec cookstyle
```

## Foodcritic
Linting is done with [Foodcritic]:
```shell
/opt/chefdk/bin/chef exec rake foodcritic .
```
