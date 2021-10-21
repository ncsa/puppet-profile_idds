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

  file { '/etc/systemd/system/usaged.service':
    source => "puppet:///modules/${module_name}/etc/systemd/system/usaged.service",
    mode   => '0664',
  }

  # FROM https://jira.ncsa.illinois.edu/browse/SVC-4552
  #   usaged only needs to run on idds-prod
  #   since the usage script is configured to run sockets to idds-prod
  if ($facts['hostname'] == 'idds-prod') {
    service { 'usaged':
      ensure  => running,
      enable  => true,
      require => File['/etc/systemd/system/usaged.service'],
    }
    # Set cron to sleep 10 minutes then restart usaged after a reboot.
    cron { 'restart_usaged':
      command => '( sleep 10m && systemctl restart usaged)',
      special => 'reboot',
    }
  } else {
    cron { 'restart_usaged':
      ensure => 'absent',
    }
  }

}
