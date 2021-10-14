# @summary Configure IDDS service users
#
# @example
#   include profile_idds::users
class profile_idds::users {

  user { 'acctd':
    ensure         => 'present',
    name           => 'acctd',
    comment        => 'IDDS Acctd',
    home           => '/home/acctd',
    managehome     => 'true',
    password       => '!!',
    purge_ssh_keys => 'false',
    shell          => '/bin/bash',
    system         => 'true'
  }
  user { 'deploy':
    ensure         => 'present',
    name           => 'deploy',
    home           => '/home/deploy',
    managehome     => 'true',
    password       => '!!',
    purge_ssh_keys => 'false',
    shell          => '/bin/bash',
    system         => 'true'
  }

  file {'/home/postgres':
    ensure => 'directory',
    owner  => 'postgres',
    group  => 'grp_202',
    mode   => '0750'
  }

  file {'/home/postgres/.ssh':
    ensure => 'directory',
    owner  => 'postgres',
    group  => 'grp_202',
    mode   => '0700'
  }

  if ($facts['hostname'] != 'idds-prod') {
    user { 'git':
      ensure         => 'present',
      name           => 'git',
      home           => '/home/git',
      managehome     => 'true',
      password       => '!!',
      purge_ssh_keys => 'false',
      shell          => '/bin/bash',
      system         => 'true'
    }
  }
}
