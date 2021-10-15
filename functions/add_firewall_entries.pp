# Add firewall entries specified as either cidr's or IP ranges for the given port.

function profile_idds::add_firewall_entries(
  Hash $address_hash,
  )
{
  $port = $address_hash['PORT']
  $port_name = $address_hash['NAME']
  $cidr = ''

  $address_hash.each | $source_name, $cidr |
  {
    # If the address contains a dash it is a range.
    if $source_name == 'PORT' {

    } elsif $source_name == 'NAME' {

    } elsif $cidr =~ /-/ {
        firewall { "${port} ALLOW ${port_name} FROM range ${source_name}":
          proto     => tcp,
          dport     => $port,
          src_range => $cidr,
          action    => accept,
        }

    } else {
        firewall { "${port} ALLOW ${port_name} FROM ${source_name}":
          proto  => tcp,
          dport  => $port,
          source => $cidr,
          action => accept,
        }
    }
  }
}
