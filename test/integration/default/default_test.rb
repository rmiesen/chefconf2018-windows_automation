# # encoding: utf-8

# Inspec test for recipe mwwfy::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('habitat') do
  it { should be_installed }
end

describe file('c:\hello.txt') do
  its('content') { should match(%r{Chef is going to reboot your server. Ha ha!}) }
end

describe registry_key('HKLM\Software\Policies\Microsoft\Internet Explorer\Main') do
  it { should exist }
  its('Isolation64Bit') { should eq 1 }
end
