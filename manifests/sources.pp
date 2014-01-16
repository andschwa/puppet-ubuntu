class ubuntu::sources {

  $repos = 'main universe multiverse restricted'

  case $ubuntu::mirror {
    us: {
      $release_location  = 'http://us.archive.ubuntu.com/ubuntu/'
      $security_location = 'http://security.ubuntu.com/ubuntu'
    }
    pnl: {
      $release_location  = 'http://mirror.pnl.gov/ubuntu/'
      $security_location = 'http://security.ubuntu.com/ubuntu'
    }
    digital_ocean: {
      $release_location  = 'http://mirrors.digitalocean.com/ubuntu/'
      $security_location = $release_location
    }
    default: {
      $release_location  = 'http://archive.ubuntu.com/ubuntu/'
      $security_location = 'http://security.ubuntu.com/ubuntu'
    }
  }

  class { 'apt::backports':
    location => $release_location
  }

  case $operatingsystemrelease {
    '12.04': {
      apt::source { 'precise':
        location => $release_location,
        repos    => $repos,
      }
      apt::source { 'precise-updates':
        location => $release_location,
        release  => 'precise-updates',
        repos    => $repos,
      }
      apt::source { 'precise-security':
        location => $security_location,
        release  => 'precise-security',
        repos    => $repos,
      }
      apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main dependencies',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
      }
      apt::ppa {
        [ 'ppa:git-core/ppa', 'ppa:keithw/mosh', ]:
      }
    }
    '13.10': {
      apt::source { 'saucy':
        location => $release_location,
        repos    => $repos,
      }
      apt::source { 'saucy-updates':
        location => $release_location,
        release  => 'saucy-updates',
        repos    => $repos,
      }
      apt::source { 'saucy-security':
        location => $security_location,
        release  => 'saucy-security',
        repos    => $repos,
      }
      apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
      }
    }
    default: {
      fail("${::lsbdistcodename} is not configured in ubuntu::sources")
    }
  }
}
