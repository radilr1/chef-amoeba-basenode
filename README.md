Amoeba "Basenode" Cookbook
====================

For usage of this cookbook, see Amoeba Deploy Tools (ADT)'s readme at:

http://github.com/AmoebaConsulting/amoeba-deploy-tools

## Note:

If you use this cookbook, you must be sure to include monit, locale, and rvm from Githubg by adding
the following to your `Cheffile`:

```
cookbook 'locale',  github: 'fnordfish/chef-locale'
cookbook 'monit',   github: 'phlipper/chef-monit'
```

## Detailed Information

This is a special "basenode" Cookbook for use with amoeba-deploy-tools. It configures minimalist
information about a server, and most importantly creates the deployment user, and disables root
login. It also dumps node information to a JSON file in the deployment user's home, which is used
to cache node information in the data_bags folder of the local machine running deployments (ADT is
based around server-less deployments). Every node in your ADT kitchen should include the
`basenode::default` cookbook to provide this functionality.

The only thing that should need to be configured is the swapfile and provider. Swap files are easy:

1. Set the `swapfile_size` attribute on the node

2. Include `basenode::swap` in the runlist (or a role)

Providers are specified in your node's `deployment/provider` attribute, which is a string name of
the provider. Available providers should be located in your kitchen's provider's databag, which is
built from the `data_bags/providers/<name.json>` files.
