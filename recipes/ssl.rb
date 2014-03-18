# Check and see if we have SSL certs requested
if node[:ssl_certs].length > 0
  # Then we must also have a private_key
  unless node[:private_key_raw] && !node[:private_key_raw].empty?
    raise "Your private_key is missing. Ensure you are using Amoeba Deploy Tools and have run " +
            "`amoeba ssl import` (see --help)"
  end

  # And we must have our directories
  directory "/etc/ssl/public" do
    owner 'root'
    group 'ssl-cert'
    mode 0755
  end

  directory "/etc/ssl/private" do
    owner 'root'
    group 'ssl-cert'
    mode 0710
  end
end

node[:ssl_certs].each do |cert_name|
  certificates  = Chef::EncryptedDataBagItem.load("certs", cert_name, node[:private_key_raw])
  cert = certificates[:cert]
  cert = cert.chomp + "\n" if cert

  ca = certificates[:ca]
  ca = ca.chomp + "\n" if ca

  key = certificates[:key]
  key = key.chomp + "\n" if key

  if cert
    file "/etc/ssl/public/#{cert_name}.crt" do
      owner 'root'
      group 'ssl-cert'
      mode 0644
      content cert
    end
  end

  if ca
    file "/etc/ssl/public/#{cert_name}-ca.crt" do
      owner 'root'
      group 'ssl-cert'
      mode 0644
      content ca
    end

    if cert
      file "/etc/ssl/public/#{cert_name}-chained.pem" do
        owner 'root'
        group 'ssl-cert'
        mode 0644
        content cert + ca
      end
    end
  end

  if key
    file "/etc/ssl/private/#{cert_name}.key" do
      owner 'root'
      group 'ssl-cert'
      mode 0640
      content key
    end
  end
end