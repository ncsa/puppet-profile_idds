# @summary Configure IDDS services
#
# @example
#   include profile_idds::services
class profile_idds::services {

  file { '/etc/systemd/system/postgresql.service':
    source => "puppet:///modules/${module_name}/etc/systemd/system/postgresql.service",
    mode   => '0664',
  }

  service { 'postgresql':
      ensure  => running,
      enable  => true,
      require => File['/etc/systemd/system/postgresql.service'],
  }

  # FROM https://jira.ncsa.illinois.edu/browse/SVC-11468
  #   usaged no longer on servers
  cron { 'restart_usaged':
    ensure => 'absent',
  }
  file { '/etc/systemd/system/usaged.service':
    ensure => 'absent',
  }
  service { 'usaged':
    ensure => stopped,
    enable => false,
  }

}
