# These packages are *always* installed (system ruby for sysadmin tasks)
%w( ohai locale timezone-ii hostname build-essential git sudo rvm::system monit openssh ).map do |r|
  include_recipe r
end

include_recipe 'amoeba_basenode::apt_update' if node[:apt_update]

# Install all the packages marked for install (prefered way to install packages is just to) add them
# to node[:packages], which is an array and Chef will merge them all together. This will ensure that
# the apt_update recipe (just above) will always run before all package installs.
#
node[:packages].map{ |p| package p}

# Setup deployer user
include_recipe 'amoeba_basenode::deployer'

# Dump the node (must be after the deployer is setup)
include_recipe 'amoeba_basenode::dump'
