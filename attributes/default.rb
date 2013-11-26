default.set_fqdn = node.name

# This is a special thing for AmoebaDeployTools. Nodes can have a provider, and the provider can
# specify values for "node.deployment" values. Here we look at the providers databag and try to
# fetch default values for node.deployment.
#
if node.deployment.provider
  node.default.deployment = data_bag_item('providers', node.deployment.provider).raw_data
end

node.default_unless['deployment']['user']  = 'deploy'
node.default_unless['deployment']['group'] = 'deploy'
node.default_unless['deployment']['home']  = '/home/deploy'