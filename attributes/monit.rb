default['default_mailer']['hostname'] = 'localhost'
default['default_mailer']['port'] = '25'
default['default_mailer']['username'] = nil
default['default_mailer']['password'] = nil
default['default_mailer']['from'] = "alerts@#{node[:name]}"
default['default_mailer']['alert_address'] = nil


# Now, override settings in the monit recipe:
override["monit"]["start_delay"] = 0
override["monit"]["polling_frequency"] = 30
override["monit"]["use_syslog"]        = true
override["monit"]["mail_alerts"]       = !node[:default_mailer][:alert_address].nil?
override["monit"]["alert_email"]       = node[:default_mailer][:alert_address]
override["monit"]["web_interface"] = {
  :enable  => true,
  :port    => 2812,
  :address => "localhost",
  :allow   => ["localhost"]
}
override["monit"]["mail"] = {
  :hostname => node['default_mailer']['hostname'],
  :port     => node['default_mailer']['port'],
  :username => node['default_mailer']['username'],
  :password => node['default_mailer']['password'],
  :from     => node['default_mailer']['from'],
  :subject  => "$SERVICE $EVENT at $DATE",
  :message  => "Monit $ACTION $SERVICE at $DATE on $HOST,\n\n$DESCRIPTION\n\nDutifully,\nMonit",
  :timeout  => 30
}
override["monit"]["default_monitrc_configs"] = ["load", "ssh"]
# Used by upstart script
override[:monit][:bin_file] =  "/usr/bin/monit"
override[:monit][:monitrc_file] = "/etc/monit/monitrc"
