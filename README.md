#drupal

##Overview

Install and manage different versions of Drupal including modules and sites.

##Usage

The module uses [Drush](https://github.com/drush-ops/drush to manage a Drupal site configuration - everytime it changes,
the site will be regenerated.

Install Drupal 7 with a bunch of modules, a theme and a library:

```
drupal::site { 'example.com':
  core_version => '7.32',
  modules      => {
    'ctools'   => '1.4',
    'token'    => '1.5',
    'pathauto' => '1.2',
    'views'    => '3.8',
  },
  themes       => {
    'omega' => '4.3',
  },
  libraries    => {
    'jquery_ui' => {
      'download' => {
        'type' => 'file',
        'url'  => 'http://jquery-ui.googlecode.com/files/jquery.ui-1.6.zip',
        'md5'  => 'c177d38bc7af59d696b2efd7dda5c605',
      },
    },
  },
}
```

Install Drupal 6:

```
drupal::site { 'example.com':
  core_version => '6.33',
}
```

Install a module from a custom location:

```
drupal::site { 'example.com':
  modules      => {
    'cck'   => {
      'download' => {
        'type' => 'file',
        'url'  => 'http://ftp.drupal.org/files/projects/cck-6.x-2.9.tar.gz',
        'md5'  => '9e30f22592b7ecf08d020e0c626efc5b',
      },
    },
  },
}
```

Apply a patch:

```
drupal::site { 'example.com':
  modules      => {
    'pathauto' => {
      'version' => '1.2',
      'patch'   => [
        'https://www.drupal.org/files/pathauto_admin.patch'
      ],
    },
  },
}
```

TODO: destination - The path is relative to that specified by the `--contrib-destination` option ('sites/all' by default for libraries)

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
