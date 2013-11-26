node.packages.map{|p| package p}
%w( git ).map{|r| include_recipe r}
%w( deployer dump base sshd ).map {|r| include_recipe "amoeba_basenode::#{r}"}
