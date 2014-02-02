class ubuntu(
  $repos = 'main universe',
  $release_location = 'http://archive.ubuntu.com/ubuntu/',
  $security_location = 'http://security.ubuntu.com/ubuntu',
  ) {

  Apt::Source {
    location => $ubuntu::release_location,
    repos    => $ubuntu::repos,
  }

  Class['apt'] -> Package <| provider == apt |>

  case $operatingsystemrelease {
    '12.04': {
      apt::source {
        'precise': ;

        'updates':
          release  => 'precise-updates';

        'security':
          release  => 'precise-security';

        'proposed':
          release => 'precise-proposed',
          pin     => 400;

        'backports':
          release => 'precise-backports',
          pin     => 200;

        'puppetlabs':
          location   => 'http://apt.puppetlabs.com',
          repos      => 'main dependencies',
          key        => '4BD6EC30',
          key_server => 'pgp.mit.edu';
      }
      apt::ppa {
        'ppa:git-core/ppa':
          before => Package['git'];

        'ppa:keithw/mosh': 
          before => Package['mosh'];

        'ppa:duplicity-team/ppa':
          before => Package['duplicity'];
      }
    }
    '13.10': {
      apt::source {
        'saucy': ;

        'saucy-updates':
          release  => 'saucy-updates';

        'saucy-security':
          release  => 'saucy-security';

        'puppetlabs':
          location   => 'http://apt.puppetlabs.com',
          repos      => 'main',
          key        => '4BD6EC30',
          key_server => 'pgp.mit.edu';
      }
    }
    default: {
      fail("${::lsbdistcodename} is not configured in ubuntu")
    }
  }

}
