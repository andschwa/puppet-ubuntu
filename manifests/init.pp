class ubuntu(
  $repos     = 'main universe',
  $location  = 'http://archive.ubuntu.com/ubuntu/',
  $keyserver = 'pgp.mit.edu',
  $sources   = {},
  $ppas      = {},
  $holds     = {},
  ) {

  Apt::Source {
    location => $location,
    repos    => $repos,
  }

  create_resources('apt::source', hiera_hash('ubuntu::sources', {}), {
    'location' => $location,
    'repos' => $repos,
    'key_server' => $key_server, } )

  create_resources('apt::ppa', hiera_hash('ubuntu::ppas', {}))

  create_resources('apt::hold', hiera_hash('ubuntu::holds', {}))
}
