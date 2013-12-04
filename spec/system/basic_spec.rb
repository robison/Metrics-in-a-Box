require 'spec_helper_system'

describe 'graphite class' do

  package_name = 'graphite'
  service_name = 'graphite'

  context 'default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'graphite': }
      EOS

      puppet_apply(pp) do |r|
        r.exit_code.should_not == 1
        r.refresh
        r.exit_code.should be_zero
      end
    end

        describe package(package_name) do
      it { should be_installed }
    end

    describe service(service_name) do
      it { should be_enabled }
      it { should be_running }
    end
  end
end

describe 'collectd class' do

  package_name = 'collectd'
  service_name = 'collectd'

  context 'default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'collectd': }
      EOS

      puppet_apply(pp) do |r|
        r.exit_code.should_not == 1
        r.refresh
        r.exit_code.should be_zero
      end
    end

    describe package(package_name) do
      it { should be_installed }
    end

    describe service(service_name) do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
