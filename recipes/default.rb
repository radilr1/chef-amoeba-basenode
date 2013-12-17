%w( ohai locale timezone-ii hostname build-essential git sudo rvm::system monit openssh ).map do |r|
  include_recipe r
end

node.packages.map{|p| package p}

%w( deployer dump ).map {|r| include_recipe "amoeba_basenode::#{r}"}
