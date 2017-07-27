require 'spec_helper'

describe UserGenreTag do
  let(:user_genre_tag) { FactoryGirl.build :user_genre_tag }
  subject { genre_tag }
  it { should respond_to(:user_id) }
  it { should respond_to(:user_genre_id) }
  it { should validate_presence_of :user_genre_id }
  it { should validate_presence_of :user_id }
  it { should belong_to :user }
  it { should belong_to :user_genre }

end
