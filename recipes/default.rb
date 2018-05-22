#
# Cookbook:: mwwfy
# Recipe:: default
#
# Copyright:: 2018, Robert Miesen, All Rights Reserved.

powershell_script 'Chocolatey' do
  code <<-EOH
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  EOH

  not_if 'Test-Path $env:programdata\chocolatey\bin\choco.exe'
end

chocolatey_package 'habitat'

reboot 'Restarting for fun and profit' do
  action :nothing
    # Note: Do _NOT_ set it to :reboot_now w/o adding guards for it, or it will reboot every time you run this recipe. (_entire_ run_list is re-ran on reboot, will loop indefinitely otherwise)
  reason 'Because I can'
  delay_mins 1
end

file 'C:\hello.txt' do
  content 'Chef is going to reboot your server. Ha ha!'
  rights :full_control, 'azure'
  rights :read, 'Everyone'

  action :create
  notifies :reboot_now, 'reboot[Restarting for fun and profit]', :immediately
end


registry_key "HKLM\\Software\\Policies\\Microsoft\\Internet Explorer\\Main" do

  values [{
    name: "Isolation64Bit",
    type: :dword,
    data: 1
  }]

  action :create
  recursive true
end

dsc_resource 'IIS' do
  resource :windowsfeature
  property :name, 'web-server'
end

# PowerShell 5 introduces side by side versioning
# And if there are multiple versions, dsc_resource requires
# us to supply a version

x_web_administration_version = '1.20.0.0'

powershell_package "xWebAdministration" do
  version x_web_administration_version
end

dsc_resource 'Default Web Site' do
  resource :xWebSite
  module_name 'xWebAdministration'
  module_version x_web_administration_version
  property :name, 'Default Web Site'
  property :state, 'Stopped'
end

dsc_resource 'ChefConf Workshop Site' do
  resource :xWebSite
  module_name 'xWebAdministration'
  module_version x_web_administration_version
  property :name, 'ChefConf'
end
