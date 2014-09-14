default.set_fqdn = node.name

node.default['deployment']['user']  = 'deploy'
node.default['deployment']['group'] = 'deploy'
node.default['deployment']['home']  = '/home/deploy'

node.default['tz'] = 'UTC'
node.default['packages'] = %w(htop atop screen imagemagick vim ssl-cert)
node.default['apt_update'] = true
node.default['ssl_certs'] = []

node.default['authorization']['sudo']['sudoers_defaults'] = []
node.default['authorization']['sudo']['groups'] = %w(wheel admin)
node.default['authorization']['sudo']['users'] = [ node.deployment.user ]

node.override['authorization']['sudo']['agent_forwarding'] = true
node.override['authorization']['sudo']['include_sudoers_d'] = true

node.override['build_essential']['compiletime'] = true

node.override['openssh']['client']['hash_known_hosts'] = 'yes'
node.override['openssh']['client']['strict_host_key_checking'] = 'no'

node.override['openssh']['server']['protocol'] = 2
node.override['openssh']['server']['permit_root_login'] = 'no'
node.override['openssh']['server']['challenge_response_authentication'] = 'no'
node.override['openssh']['server']['password_authentication'] = 'no'
node.override['openssh']['server']['use_privilege_separation'] = 'sandbox'
node.override['openssh']['server']['ignore_rhosts'] = 'yes'
node.override['openssh']['server']['x11_forwarding'] = 'no'
node.override['openssh']['server']['print_motd'] = 'no'
node.override['openssh']['server']['use_dns'] = 'no'
node.override['openssh']['server']['subsystem'] = 'sftp /usr/lib/openssh/sftp-server'
node.override['openssh']['server']['allow_agent_forwarding'] = 'yes'
