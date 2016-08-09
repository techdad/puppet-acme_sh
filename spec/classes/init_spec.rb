require 'spec_helper'
describe 'acme_sh' do
  context 'with default values for all parameters' do
    it { should contain_class('acme_sh') }
  end
end
