class { '::drupal': }

::drupal::site { 'example.com':
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

class { '::php':
  composer   => false,
  fpm        => true,
  extensions => {
    xml => {},
  },
  before     => Class['drupal'],
}

