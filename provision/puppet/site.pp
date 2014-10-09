node /^www/ {
  class {
    'apache':
      default_vhost => false;
  }

  apache::vhost { 'localhost':
    port => '8081',
    docroot => '/var/www/htdocs'
  }

  file {
    '/var/www/htdocs':
      ensure => directory;

    '/var/www/htdocs/index.html':
      ensure => present,
      content => "Hello from $::hostname\n";
  }
}
