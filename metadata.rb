name             "basenode"
maintainer       "Daniel Jabbour"
maintainer_email "sayhi@amoe.ba"
license          "MIT"
description      "Configures basic system-level stuff for use woth Amoeba Deploy Tools."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe            "basenode", "Basic functionality needed for AmoebaDeployTools (deployer user and node config JSON dump)"
recipe            "basenode::swap", "Configures a swapfile on the node (based on swapfile_size attribute)"

# Might not actually need swap, but we do depend on it
depends "swap"

attribute "swapfile_size",
  :description => "The size of the system swap (integer in MB).",
  :required    => "optional",
  :default     => "4096"

attribute "set_fqdn",
  :description => "The FQDN (fully qualified domain name) of the node. Defaults to <node.name>.",
  :type        => "string",
  :required    => "optional"

attribute "deployment/provider",
  :description => "The provider to use (from AmoebaDeployTools). Providers specify default values for node/deployment attributes. (default: none)",
  :type        => "string",
  :required    => "optional"
