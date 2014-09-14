# This is a special thing for AmoebaDeployTools. Nodes can have a provider, and the provider can
# specify values for "node.deployment" values. Here we look at the providers databag and try to
# fetch default values for node.deployment.
#
if node[:deployment][:provider]
  # Here we're adding the provider fields under our own default fields. This is because the provider
  # could specify fields we do not have defaults for in the "provider", but we want out defaults to
  # be the ones applying to the node (for instance username of the deployment user).
  provider_deployment_info = data_bag_item('providers', node[:deployment][:provider]).raw_data.to_hash
  provider_deployment_info.delete('id') if provider_deployment_info.has_key?('id')
  node.default[:deployment] = provider_deployment_info.merge(node.default[:deployment])
end

group node[:deployment][:group] do
  gid       5000
end

user node[:deployment][:user] do
  comment   'Chef deployment user'
  uid       5000
  gid       5000
  shell     '/bin/bash'
  home      node[:deployment][:home]
  supports  :manage_home => true
end

sudo node[:deployment][:user] do
  user      node[:deployment][:user]
  group     node[:deployment][:group]
  commands  ['ALL']
  nopasswd  true
end

puts(app.inspect)
puts(app[:name])
authorized_keys 'root' do
  user      node[:deployment][:user]
  home      node[:deployment][:home]
end
