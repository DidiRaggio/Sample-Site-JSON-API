require 'spec_helper'

describe Platform do
  let(:platform) { FactoryGirl.build :platform }
  subject { platform }
  it { should respond_to(:name) }
  it { should validate_presence_of :name }
  it { should have_many(:platform_tags) }
  it { should have_many(:pitches).through(:platform_tags) }
end

