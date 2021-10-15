# @summary Allow ssh for service type accounts
# 
# @param acctd_subnets
#   List of subnets that acctd can ssh from
#
# @param acctd_groups
#   List of groups that are allowed for acctd ssh access
#
# @param acctd_users
#   List of users that are allowed for acctd ssh access
# 
# @param dev_subnets
#   List of subnets that developer service users can ssh from
#
# @param dev_groups
#   List of developer service groups that are allowed for ssh access
#
# @param dev_users
#   List of developer service users that are allowed for ssh access
#
# @example
#   include profile_idds::ssh
class profile_idds::ssh (
  $acctd_subnets,
  $acctd_groups,
  $acctd_users,
  $dev_subnets,
  $dev_users,
  $dev_groups,
){

  $params = {
    'PubkeyAuthentication'  => 'yes',
    'AuthenticationMethods' => 'publickey',
    'Banner'                => 'none',
    'X11Forwarding'         => 'no',
  }

  ::sshd::allow_from{ 'sshd allow acctd access from acctd clients':
    hostlist                => $acctd_subnets,
    groups                  => $acctd_groups,
    users                   => $acctd_users,
    additional_match_params => $params,
  }

  ::sshd::allow_from{ 'sshd allow developer service users access from dev nodes':
    hostlist                => $dev_subnets,
    groups                  => $dev_groups,
    users                   => $dev_users,
    additional_match_params => $params,
  }


  ## IF $dev_groups CONTAINS GROUP git
  if ( 'git' in $dev_groups ) {
    # ALSO NEED access.conf ENTRY FOR ORIGIN 'ALL EXCEPT LOCAL'
    # pam_access DOES NOT ALLOW FOR 'ALL EXCEPT LOCAL' SO USING 'ALL'
    pam_access::entry { 'Allow group git access from ALL':
      group      => 'git',
      origin     => 'ALL',
      permission => '+',
      position   => '-1',
    }
  }
  ## IF $dev_users CONTAINS USER git
  if ( 'git' in $dev_users ) {
    # ALSO NEED access.conf ENTRY FOR ORIGIN 'ALL EXCEPT LOCAL'
    # pam_access DOES NOT ALLOW FOR 'ALL EXCEPT LOCAL' SO USING 'ALL'
    pam_access::entry { 'Allow user git access from ALL':
      user       => 'git',
      origin     => 'ALL',
      permission => '+',
      position   => '-1',
    }
  }

}

