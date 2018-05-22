#
# Cookbook:: mwwfy
# Spec:: default
#
# Copyright:: 2018, Robert Miesen, All Rights Reserved.

require 'spec_helper'

describe 'mwwfy::default' do
  context 'When all attributes are default, on Win2k16' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2016')
      runner.converge(described_recipe)
    end
  
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    context 'file[C:\hello.txt]' do
      it 'sets Read for Everyone' do
        expect(chef_run).to create_file('c:\hello.txt').with(
          rights: [{ permissions: :full_control, principals: 'azure'},
                   { permissions: :read, principals: 'Everyone'}]
        )
      end
    end
  end
end
