require 'spec_helper'

describe GenreTag do
  let(:genre_tag) { FactoryGirl.build :genre_tag }
  subject { genre_tag }
  it { should respond_to(:pitch_id) }
  it { should respond_to(:genre_id) }
  it { should validate_presence_of :genre_id }
  it { should validate_presence_of :pitch_id }
  it { should belong_to :pitch }
  it { should belong_to :genre }

end
