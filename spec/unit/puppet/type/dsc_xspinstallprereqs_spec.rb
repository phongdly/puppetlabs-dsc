#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_xspinstallprereqs) do

  let :dsc_xspinstallprereqs do
    Puppet::Type.type(:dsc_xspinstallprereqs).new(
      :name     => 'foo',
      :dsc_installerpath => 'foo',
    )
  end

  it "should stringify normally" do
    expect(dsc_xspinstallprereqs.to_s).to eq("Dsc_xspinstallprereqs[foo]")
  end

  it 'should require that dsc_installerpath is specified' do
    #dsc_xspinstallprereqs[:dsc_installerpath]
    expect { Puppet::Type.type(:dsc_xspinstallprereqs).new(
      :name     => 'foo',
      :dsc_onlinemode => true,
      :dsc_sqlncli => 'foo',
      :dsc_powershell => 'foo',
      :dsc_netfx => 'foo',
      :dsc_idfx => 'foo',
      :dsc_sync => 'foo',
      :dsc_appfabric => 'foo',
      :dsc_idfx11 => 'foo',
      :dsc_msipcclient => 'foo',
      :dsc_wcfdataservices => 'foo',
      :dsc_kb2671763 => 'foo',
      :dsc_wcfdataservices56 => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_installerpath is a required attribute/)
  end

  it 'should not accept array for dsc_installerpath' do
    expect{dsc_xspinstallprereqs[:dsc_installerpath] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_installerpath' do
    expect{dsc_xspinstallprereqs[:dsc_installerpath] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_installerpath' do
    expect{dsc_xspinstallprereqs[:dsc_installerpath] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_installerpath' do
    expect{dsc_xspinstallprereqs[:dsc_installerpath] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_onlinemode' do
    expect{dsc_xspinstallprereqs[:dsc_onlinemode] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept boolean for dsc_onlinemode' do
    dsc_xspinstallprereqs[:dsc_onlinemode] = true
    expect(dsc_xspinstallprereqs[:dsc_onlinemode]).to eq(true)
  end

  it "should accept boolean-like value 'true' and munge this value to boolean for dsc_onlinemode" do
    dsc_xspinstallprereqs[:dsc_onlinemode] = 'true'
    expect(dsc_xspinstallprereqs[:dsc_onlinemode]).to eq(true)
  end

  it "should accept boolean-like value 'false' and munge this value to boolean for dsc_onlinemode" do
    dsc_xspinstallprereqs[:dsc_onlinemode] = 'false'
    expect(dsc_xspinstallprereqs[:dsc_onlinemode]).to eq(false)
  end

  it "should accept boolean-like value 'True' and munge this value to boolean for dsc_onlinemode" do
    dsc_xspinstallprereqs[:dsc_onlinemode] = 'True'
    expect(dsc_xspinstallprereqs[:dsc_onlinemode]).to eq(true)
  end

  it "should accept boolean-like value 'False' and munge this value to boolean for dsc_onlinemode" do
    dsc_xspinstallprereqs[:dsc_onlinemode] = 'False'
    expect(dsc_xspinstallprereqs[:dsc_onlinemode]).to eq(false)
  end

  it "should accept boolean-like value :true and munge this value to boolean for dsc_onlinemode" do
    dsc_xspinstallprereqs[:dsc_onlinemode] = :true
    expect(dsc_xspinstallprereqs[:dsc_onlinemode]).to eq(true)
  end

  it "should accept boolean-like value :false and munge this value to boolean for dsc_onlinemode" do
    dsc_xspinstallprereqs[:dsc_onlinemode] = :false
    expect(dsc_xspinstallprereqs[:dsc_onlinemode]).to eq(false)
  end

  it 'should not accept int for dsc_onlinemode' do
    expect{dsc_xspinstallprereqs[:dsc_onlinemode] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_onlinemode' do
    expect{dsc_xspinstallprereqs[:dsc_onlinemode] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_sqlncli' do
    expect{dsc_xspinstallprereqs[:dsc_sqlncli] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_sqlncli' do
    expect{dsc_xspinstallprereqs[:dsc_sqlncli] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_sqlncli' do
    expect{dsc_xspinstallprereqs[:dsc_sqlncli] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_sqlncli' do
    expect{dsc_xspinstallprereqs[:dsc_sqlncli] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_powershell' do
    expect{dsc_xspinstallprereqs[:dsc_powershell] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_powershell' do
    expect{dsc_xspinstallprereqs[:dsc_powershell] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_powershell' do
    expect{dsc_xspinstallprereqs[:dsc_powershell] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_powershell' do
    expect{dsc_xspinstallprereqs[:dsc_powershell] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_netfx' do
    expect{dsc_xspinstallprereqs[:dsc_netfx] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_netfx' do
    expect{dsc_xspinstallprereqs[:dsc_netfx] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_netfx' do
    expect{dsc_xspinstallprereqs[:dsc_netfx] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_netfx' do
    expect{dsc_xspinstallprereqs[:dsc_netfx] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_idfx' do
    expect{dsc_xspinstallprereqs[:dsc_idfx] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_idfx' do
    expect{dsc_xspinstallprereqs[:dsc_idfx] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_idfx' do
    expect{dsc_xspinstallprereqs[:dsc_idfx] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_idfx' do
    expect{dsc_xspinstallprereqs[:dsc_idfx] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_sync' do
    expect{dsc_xspinstallprereqs[:dsc_sync] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_sync' do
    expect{dsc_xspinstallprereqs[:dsc_sync] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_sync' do
    expect{dsc_xspinstallprereqs[:dsc_sync] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_sync' do
    expect{dsc_xspinstallprereqs[:dsc_sync] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_appfabric' do
    expect{dsc_xspinstallprereqs[:dsc_appfabric] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_appfabric' do
    expect{dsc_xspinstallprereqs[:dsc_appfabric] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_appfabric' do
    expect{dsc_xspinstallprereqs[:dsc_appfabric] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_appfabric' do
    expect{dsc_xspinstallprereqs[:dsc_appfabric] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_idfx11' do
    expect{dsc_xspinstallprereqs[:dsc_idfx11] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_idfx11' do
    expect{dsc_xspinstallprereqs[:dsc_idfx11] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_idfx11' do
    expect{dsc_xspinstallprereqs[:dsc_idfx11] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_idfx11' do
    expect{dsc_xspinstallprereqs[:dsc_idfx11] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_msipcclient' do
    expect{dsc_xspinstallprereqs[:dsc_msipcclient] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_msipcclient' do
    expect{dsc_xspinstallprereqs[:dsc_msipcclient] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_msipcclient' do
    expect{dsc_xspinstallprereqs[:dsc_msipcclient] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_msipcclient' do
    expect{dsc_xspinstallprereqs[:dsc_msipcclient] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_wcfdataservices' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_wcfdataservices' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_wcfdataservices' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_wcfdataservices' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_kb2671763' do
    expect{dsc_xspinstallprereqs[:dsc_kb2671763] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_kb2671763' do
    expect{dsc_xspinstallprereqs[:dsc_kb2671763] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_kb2671763' do
    expect{dsc_xspinstallprereqs[:dsc_kb2671763] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_kb2671763' do
    expect{dsc_xspinstallprereqs[:dsc_kb2671763] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_wcfdataservices56' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices56] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_wcfdataservices56' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices56] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_wcfdataservices56' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices56] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_wcfdataservices56' do
    expect{dsc_xspinstallprereqs[:dsc_wcfdataservices56] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_xspinstallprereqs)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_xspinstallprereqs)
    end

    describe "when dscmeta_import_resource is true (default) and dscmeta_module_name existing/is defined " do

      it "should compute powershell dsc test script with Invoke-DscResource" do
        expect(@provider.ps_script_content('test')).to match(/Invoke-DscResource/)
      end

      it "should compute powershell dsc test script with method Test" do
        expect(@provider.ps_script_content('test')).to match(/Method\s+=\s*'test'/)
      end

      it "should compute powershell dsc set script with Invoke-DscResource" do
        expect(@provider.ps_script_content('set')).to match(/Invoke-DscResource/)
      end

      it "should compute powershell dsc test script with method Set" do
        expect(@provider.ps_script_content('set')).to match(/Method\s+=\s*'set'/)
      end

    end

  end
end
