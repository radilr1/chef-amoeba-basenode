name             "amoeba_basenode"
maintainer       "Daniel Jabbour"
maintainer_email "sayhi@amoe.ba"
license          "MIT"
description      "Configures basic system-level stuff for use woth Amoeba Deploy Tools."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"

recipe            "amoeba_basenode", "Basic functionality needed for AmoebaDeployTools (deployer user and node config JSON dump)"
recipe            "amoeba_basenode::swap", "Configures a swapfile on the node (based on swapfile_size attribute)"

# Might not actually need swap, but we do depend on it
depends "swap"

# These are configured in the recipes/base wrapper
depends "openssh"
depends "ohai"
depends "locale", ">= 0.1.0" # must use version from github: 'fnordfish/chef-locale'
depends "timezone-ii"
depends "hostname"
depends "build-essential"
depends "git"
depends "sudo"
depends "monit", ">= 1.5.0" # must use version from github: 'phlipper/chef-monit'

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

attribute "default_mailer/hostname",
  :description => "Mail settings for outgoing alert messages (used by monit and possibly others)",
  :required    => "optional",
  :default     => "localhost"

attribute "default_mailer/port",
          :description => "Mail settings for outgoing alert messages (used by monit and possibly others)",
          :required    => "optional",
          :default     => "25"

attribute "default_mailer/username",
          :description => "Mail settings for outgoing alert messages (used by monit and possibly others)",
          :required    => "optional",
          :default     => "nil"

attribute "default_mailer/password",
          :description => "Mail settings for outgoing alert messages (used by monit and possibly others)",
          :required    => "optional",
          :default     => "nil"

attribute "default_mailer/from",
          :description => "Mail settings for outgoing alert messages (used by monit and possibly others)",
          :required    => "optional",
          :default     => "alerts@{node[:fqdn]}"

attribute "default_mailer/alert_address",
          :description => "EMail address to receive alerts (monit and others). Defaults to nil (disables alert emails)",
          :required    => "optional",
          :default     => "nil"
