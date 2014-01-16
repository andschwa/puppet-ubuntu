class ubuntu($mirror = 'us') {
  
  include ubuntu::sources
  include ubuntu::packages
  
  class { 'apt':
    always_apt_update    => false,
    purge_sources_list   => true,
    purge_sources_list_d => true,
  } -> Package <| provider == apt |>
}
