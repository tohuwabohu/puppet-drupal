#drupal

##Overview

Install and manage different versions of Drupal including modules and sites.

##Usage


Install Drupal 7 with a bunch of modules:

```
drupal::site { 'example.com':
  core_version => '7.32',
  modules      => {
    'ctools'   => '1.4',
    'token'    => '1.5',
    'pathauto' => '1.2',
    'views'    => '3.8',
  },
}
```

TODO: add a note about required tools to handle compressed archives like unzip


##Limitations

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian Linux 7.0 (Wheezy)

[![Build Status](https://travis-ci.org/tohuwabohu/puppet-drupal.png?branch=master)](https://travis-ci.org/tohuwabohu/puppet-drupal)

##Testing

Run the unit tests

```
bundle exec rake spec
```

Run the acceptance tests

```
bundle exec rake acceptance
```

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


##Contributors

The list of contributors can be found on [GitHub](https://github.com/tohuwabohu/puppet-drupal/graphs/contributors).
