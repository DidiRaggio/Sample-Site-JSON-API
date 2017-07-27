require 'spec_helper'

describe Pitch do
  let(:pitch) { FactoryGirl.build :pitch }
  subject { pitch }
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:video) }
  it { should respond_to(:expected_release_date) }
  it { should respond_to(:website) }

  it { should respond_to(:user_id) }

    # it "prints the pitch created in factory" do
    # 	puts subject
    # 	puts subject.title
    # 	puts subject.body
    # 	puts subject.video
    # 	puts subject.expected_release_date
    # 	puts subject.website
    # 	puts subject.user_id
    # end

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it "is valid if expected_release_date is in the future" do
  	expect(pitch.expected_release_date).to be > Time.now
  end
  # it { should validate_inclusion_of(pitch.user.is_dev).in_array([true, false]) }
  it { should validate_presence_of :user_id }
  it { should belong_to :user }
  it { should have_many(:genre_tags) }
  it { should have_many(:genres).through(:genre_tags) }
  it { should have_many(:platform_tags) }
  it { should have_many(:platforms).through(:platform_tags) }
end

