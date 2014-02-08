class ubuntu(
  $repos = 'main universe',
  $location = 'http://archive.ubuntu.com/ubuntu/',
  $keyserver = 'pgp.mit.edu',  
  $sources = {},
  $ppas = {},
  ) {

  Apt::Source {
    location => $location,
    repos    => $repos,
  }

  Class[ 'apt', 'apt::source', 'apt::ppa' ] -> Package <| provider == apt |>

  create_resources('apt::source', $sources, {
    'location' => $location,
    'repos' => $repos,
    'key_server' => $key_server, } )

  create_resources('apt::ppa', $ppas)
}
