require 'spec_helper'

describe 'graphite' do

 let :facts do
   {:osfamily => 'RedHat'}
 end

 it { should contain_package('graphite').with(
   :ensure => 'installed'
 )}

 it { should contain_service('graphite').with(
   :ensure => 'running'
 )}


 context 'on non supported opearting systems' do
   let :facts do
     {:osfamily => 'foo'}
   end

   it 'should fail' do
     expect { subject }.to  raise_error(/foo is not supported/)
   end
 end

end
