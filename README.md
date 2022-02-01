# profile_idds

![pdk-validate](https://github.com/ncsa/puppet-profile_idds/workflows/pdk-validate/badge.svg)
![yamllint](https://github.com/ncsa/puppet-profile_idds/workflows/yamllint/badge.svg)

NCSA Common Puppet Profiles - configure IDDS services

## Usage

To install and configure:

```puppet
include profile_idds
```

## Configuration

The following parameters need to be set in hiera:
```
profile_idds::firewall::firewall_hash:
  allowed_db:
    NAME: "postgres"
    PORT: "5432"
    Example subnet: "141.142.100.1/24"
  allowed_secure_web:
    NAME: "https"
    PORT: "443"
    Example subnet: "141.142.100.1/24"
  allowed_web:
    NAME: "http"
    PORT: "80"
    Example subnet: "141.142.100.1/24"

profile_idds::ssh::acctd_subnets:
  - "141.142.100.1/24"  # Example subnet
```

## Dependencies
n/a

## Reference

[REFERENCE.md](REFERENCE.md)

