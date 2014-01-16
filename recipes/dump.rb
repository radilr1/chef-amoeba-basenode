# Dump node attributes to json file (so we have some known node state)
node_filename = "#{node[:deployment][:home]}/node.json"
log "Dumping node definition to: [#{node_filename}]"
ruby_block "dump_node_json" do
  block do
    # for_json contains the individual default / automatic sections. to_hash is merged / flat
    node_hash = JSON.parse(JSON(node.to_hash))

    # Remove ident as host keys will be managed by us and it's not useful anymore
    node_hash['deployment'].delete('ident')

    File.open(node_filename, 'w') do |f|
      f.write( JSON(node_hash) )
      f.chmod( 0640 )
    end
    FileUtils.chown node.deployment.user, node.deployment.group, node_filename
  end
end
