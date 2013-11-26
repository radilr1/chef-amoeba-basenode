node.packages.map{|p| package p}
%w( git ).map{|r| include_recipe r}
%w( deployer dump ).map {|r| include_recipe "basenode::#{r}"}
