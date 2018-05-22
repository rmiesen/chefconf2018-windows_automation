#
# Cookbook:: mwwfy
# Recipe:: default
#
# Copyright:: 2018, Robert Miesen, All Rights Reserved.

reboot 'Restarting for fun and profit' do
  action :nothing
  reason 'Because I can'
  delay_mins 1
end

file 'C:\hello.txt' do
  content 'Chef is going to reboot your server. Ha ha!'

  action :create

  notifies :reboot_now, 'reboot[Restarting for fun and profit]', :immediately
end
