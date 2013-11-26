node.default['tz'] = 'UTC'
node.default['packages'] = %w(htop atop screen imagemagick vim)
node.default['authorization']['sudo']['sudoers_defaults'] = []
node.default['authorization']['sudo']['groups'] = %w(wheel admin)
node.default['authorization']['sudo']['users'] = [ node.deployment.user ]
node.default['authorization']['sudo']['agent_forwarding'] = true
node.default['authorization']['sudo']['include_sudoers_d'] = true
node.default['monit']['poll_period'] = 30
node.default['monit']['poll_start_delay'] = false
node.default['build_essential']['compiletime'] = true


include_recipe 'ohai'
include_recipe 'locale'
include_recipe 'timezone-ii'
include_recipe 'hostname'
include_recipe 'build-essential'
include_recipe 'git'
include_recipe 'sudo'
include_recipe 'rvm::system'
include_recipe 'monit'