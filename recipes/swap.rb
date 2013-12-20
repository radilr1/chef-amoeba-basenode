# Totally optional recipe for a swap file (rather than partition)
# To use, just set node[:swapfile_size] in your node's attributes
# and include the recipe

swap_file '/var/swapfile' do
  size    node.swapfile_size
  persist true
end
