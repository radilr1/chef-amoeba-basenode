require 'chef/rewind'

include_recipe 'monit'

# Fix the monit service to use upstart
rewind service: 'monit'

template 'monit.upstart.conf' do
  path '/etc/init/monit.conf'
  source 'monit.upstart.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
end

service 'monit' do
  provider Chef::Provider::Service::Upstart
  supports status: true, restart: true, reload: true
  action :enable
end
