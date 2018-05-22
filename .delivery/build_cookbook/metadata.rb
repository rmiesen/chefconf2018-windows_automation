name 'build_cookbook'
maintainer 'Robert Miesen'
maintainer_email 'robert.miesen@gmail.com'
license 'all_rights'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'delivery-truck'
