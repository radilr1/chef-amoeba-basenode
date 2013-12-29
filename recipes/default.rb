# These packages are *always* installed (system ruby for sysadmin tasks)
%w( ohai locale timezone-ii hostname build-essential git sudo rvm::system openssh ).map do |r|
  include_recipe r
end

include_recipe 'amoeba_basenode::apt_update' if node[:apt_update]

# Install all the packages marked for install (prefered way to install packages is just to) add them
# to node[:packages], which is an array and Chef will merge them all together. This will ensure that
# the apt_update recipe (just above) will always run before all package installs.
#
node[:packages].map{ |p| package p}

# Setup the rewind gem so that we can use it in this cookbook's (and other cookbooks') recipes
# See: https://github.com/bryanwb/chef-rewind
chef_gem 'chef-rewind'

# NOTE: dump MUST be the last action taken by this cookbook
%w( deployer monit dump ).each do |r|
  include_recipe "amoeba_basenode::#{r}"
end