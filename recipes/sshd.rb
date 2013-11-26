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

include_recipe "openssh"