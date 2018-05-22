#
# Cookbook:: mwwfy
# Recipe:: default
#
# Copyright:: 2018, Robert Miesen, All Rights Reserved.

reboot 'Restarting for fun and profit' do
  action :nothing
    # Note: Do _NOT_ set it to :reboot_now w/o adding guards for it, or it will reboot every time you run this recipe. (_entire_ run_list is re-ran on reboot, will loop indefinitely otherwise)
  reason 'Because I can'
  delay_mins 1
end

file 'C:\hello.txt' do
  content 'Chef is going to reboot your server. Ha ha!'

  action :create

  notifies :reboot_now, 'reboot[Restarting for fun and profit]', :immediately
end
