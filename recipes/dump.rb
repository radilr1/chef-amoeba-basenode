# Dump node attributes to json file (so we have some known node state)
node_filename = "#{node[:deployment][:home]}/node.json"
log "Dumping node definition to: [#{node_filename}]"
ruby_block "dump_node_json" do
  block do
    File.open(node_filename, 'w') do |f|
      f.write(JSON(node.to_hash.merge(node.for_json)))
      f.chmod(0640)
    end
    FileUtils.chown node.deployment.user, node.deployment.group, node_filename
  end
end
