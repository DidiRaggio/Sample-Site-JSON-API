require 'spec_helper'

describe Submission do
  let(:submission) { FactoryGirl.build :submission }
  subject { submission }

  it { should respond_to(:is_approved) }
  it { should respond_to(:dev_id) }
  it { should respond_to(:influencer_id) }

  it { should respond_to(:pitch_id) }

  it { should validate_inclusion_of(:is_approved).in_array([true, false]) }

  it { should belong_to :dev }
  it { should belong_to :influencer }


  it { p subject.pitch.user_id
    should belong_to :pitch }
end


