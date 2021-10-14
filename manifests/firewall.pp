# Set up the firewall for the server.
# The defaults below can be overridden inside Foreman.

class profile_idds::firewall (

  # The parameter is a hash of hashes.
  # Each contained hash should have 2 entries 'CIDR' and "NAME'.

  Hash $firewall_hash,
) {
  $firewall_hash.each | $tag, $sub_hash |
  {
    common::add_firewall_entries($sub_hash)
  }
}
