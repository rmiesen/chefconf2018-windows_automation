# # encoding: utf-8

# Inspec test for recipe mwwfy::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('c:\hello.txt') do
  its('content') { should match(%r{Chef is going to reboot your server. Ha ha!}) }
end