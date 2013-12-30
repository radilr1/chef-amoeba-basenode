require 'chef/rewind'

template 'monit.upstart.conf' do
  path '/etc/init/monit.conf'
  source 'monit.upstart.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
end

include_recipe 'monit'

# Fix the monit service to use upstart by removing the default one
unwind 'service[monit]'

service 'monit' do
  provider Chef::Provider::Service::Upstart
  supports status: true, restart: true, reload: true, start: true
end
