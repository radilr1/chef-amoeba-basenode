require 'json'

# A simple file dumper that's quieter than Chef's
def dump_node_file(filename)
  log "Dumping node definition to: [#{filename}]"
  File.open(filename, 'w') do |f|
    f.write(JSON(node.to_hash.merge(node.for_json)))
    f.chmod(0640)
  end
  FileUtils.chown node.deployment.user, node.deployment.group, filename
end
