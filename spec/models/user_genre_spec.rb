require 'spec_helper'

describe UserGenre do
  let(:user_genre) { FactoryGirl.build :user_genre }
  subject { genre }
  it { should respond_to(:name) }
  it { should validate_presence_of :name }
  it { should have_many(:user_genre_tags) }
  it { should have_many(:users).through(:user_genre_tags) }
end

