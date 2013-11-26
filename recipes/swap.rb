swap_file '/var/swapfile' do
  size    node.swapfile_size
  persist true
end
