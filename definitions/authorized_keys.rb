define :authorized_keys, user: nil, env: "development", home: nil do
  user_name   = params[:user] || params[:name]
  user_home   = params[:home] || "/home/#{user_name}"
  env         = params[:env]

  ssh_dir = "#{user_home}/.ssh"

  directory ssh_dir do
    owner     user_name
    mode      0755
    recursive true
  end

  # load authorized_keys data_bag for password-less login
  pubkeys = []
  key_users = data_bag 'authorized_keys'
  if key_users.include? user_name
    puts(env)
    puts(data_bag_item('authorized_keys', user_name).inspect)
    pubkeys += data_bag_item('authorized_keys', user_name)['environments'][env].split("\n")
  end

  # 'root' keys are applied to all users, not just for root
  if user_name != 'root' and key_users.include? 'root'
    pubkeys += data_bag_item('authorized_keys', 'root')['environments'][app.name].split("\n")
  end

  pubkey_file = "#{ssh_dir}/id_rsa.pub"
  if File.exists? pubkey_file
    pubkeys.push File.read(pubkey_file)
  end

  file "#{ssh_dir}/authorized_keys" do
    owner     user_name
    mode      0644
    content   pubkeys.join "\n"
  end
end
