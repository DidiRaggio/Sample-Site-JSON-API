require 'spec_helper'

describe PlatformTag do
  let(:platform_tag) { FactoryGirl.build :platform_tag }
  subject { platform_tag }
  it { should respond_to(:pitch_id) }
  it { should respond_to(:platform_id) }
  it { should validate_presence_of :platform_id }
  it { should validate_presence_of :pitch_id }
  it { should belong_to :pitch }
  it { should belong_to :platform }

end