class ubuntu::packages {

  case $operatingsystemrelease {
    '13.10': {
      package { 'silversearcher-ag':
        ensure => latest,
      }
    }
  }

  package { [ 'ack-grep', 'aptitude', 'gnupg2', 'mailutils' ]:
    ensure => latest,
  }
}
