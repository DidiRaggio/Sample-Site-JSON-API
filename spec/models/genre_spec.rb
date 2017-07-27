require 'spec_helper'

describe Genre do
  let(:genre) { FactoryGirl.build :genre }
  subject { genre }
  it { should respond_to(:name) }
  it { should validate_presence_of :name }
  it { should have_many(:genre_tags) }
  it { should have_many(:pitches).through(:genre_tags) }
end

