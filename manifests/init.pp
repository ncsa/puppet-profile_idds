# @summary Configure IDDS services, etc
#
# @example
#   include profile_idds
class profile_idds {

  include profile_idds::firewall
  include profile_idds::users
  include profile_idds::services

}
