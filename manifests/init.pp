class ubuntu(
  $repos = [ 'security', ],
  $release_location = 'http://archive.ubuntu.com/ubuntu/',
  $security_location = 'http://security.ubuntu.com/ubuntu',
  ) {

  Class['apt'] -> Package <| provider == apt |>

  case $operatingsystemrelease {
    '12.04': {
      apt::source { 'precise':
        location => $ubuntu::release_location,
        repos    => $ubuntu::repos,
      }
      apt::source { 'precise-updates':
        location => $ubuntu::release_location,
        release  => 'precise-updates',
        repos    => $ubuntu::repos,
      }
      apt::source { 'precise-security':
        location => $ubuntu::security_location,
        release  => 'precise-security',
        repos    => $ubuntu::repos,
      }
      apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main dependencies',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
      }
      apt::ppa { 'ppa:git-core/ppa':
        before => Package['git']
      }
      apt::ppa { 'ppa:keithw/mosh': 
        before => Package['mosh']
      }
      ensure_resource('package', 'mosh', {'ensure' => 'present'})
      ensure_resource('package', 'git', {'ensure' => 'latest'})
    }
    '13.10': {
      apt::source { 'saucy':
        location => $ubuntu::release_location,
        repos    => $ubuntu::repos,
      }
      apt::source { 'saucy-updates':
        location => $ubuntu::release_location,
        release  => 'saucy-updates',
        repos    => $ubuntu::repos,
      }
      apt::source { 'saucy-security':
        location => $ubuntu::security_location,
        release  => 'saucy-security',
        repos    => $ubuntu::repos,
      }
      apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
      }
      package { 'silversearcher-ag': }
    }
    default: {
      fail("${::lsbdistcodename} is not configured in ubuntu")
    }
  }
}
