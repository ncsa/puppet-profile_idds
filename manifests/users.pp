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
    system         => 'true',
  }
  user { 'amie':
    ensure         => 'present',
    name           => 'amie',
    comment        => 'NCSA amie',
    home           => '/home/amie',
    managehome     => 'true',
    password       => '!!',
    purge_ssh_keys => 'false',
    shell          => '/bin/bash',
    system         => 'true',
  }
  user { 'deploy':
    ensure         => 'present',
    name           => 'deploy',
    home           => '/home/deploy',
    managehome     => 'true',
    password       => '!!',
    purge_ssh_keys => 'false',
    shell          => '/bin/bash',
    system         => 'true',
  }
  group { 'grp_202':
    ensure     => 'present',
    name       => 'grp_202',
    forcelocal => true,
    gid        => '202',
  }
  user { 'postgres':
    ensure         => 'present',
    name           => 'postgres',
    forcelocal     => true,
    gid            => '202',
    home           => '/home/postgres',
    managehome     => false,
    #managehome     => true,
    password       => '!!',
    purge_ssh_keys => 'false',
    shell          => '/sbin/nologin',
    #system         => 'true'
    uid            => '54048',
  }
  user { 'svna':
    ensure         => 'present',
    name           => 'svna',
    comment        => 'NCSA svna',
    home           => '/home/svna',
    managehome     => 'true',
    password       => '!!',
    purge_ssh_keys => 'false',
    shell          => '/bin/bash',
    system         => 'true',
  }

  # ALLOW USERS TO RUN CRON
  pam_access::entry { 'amie-cron':
    user   => 'amie',
    origin => 'cron',
  }
  pam_access::entry { 'deploy-cron':
    user   => 'deploy',
    origin => 'cron',
  }
  pam_access::entry { 'svna-cron':
    user   => 'svna',
    origin => 'cron',
  }

  file { '/home/postgres':
    ensure => 'directory',
    owner  => 'postgres',
    group  => 'grp_202',
    mode   => '0750',
  }

  ## WHY IS THE FOLLOWING HERE?          - wglick 2022-01-20
  ## - THE postgres USER CANNOT SSH INTO ANY IDDS SERVERS
  ## - GUESS IT COULD SSH FROM THE IDDS SERVER, BUT NOT CONVINCED IT NEEDS TO
  file { '/home/postgres/.ssh':
    ensure => 'directory',
    owner  => 'postgres',
    group  => 'grp_202',
    mode   => '0700',
  }
}
