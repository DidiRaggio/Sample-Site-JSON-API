require 'spec_helper'

describe Api::V1::PitchesController do

  describe "GET #show as Dev" do
    before(:each) do
      @pitch = FactoryGirl.create :pitch
      api_authorization_header @pitch.user.auth_token
      get :show, params: { user_id: @pitch.user.id, id: @pitch.id }
    end

    it "returns the information about a reporter on a hash" do
      pitch_response = json_response
      expect(pitch_response[:title]).to eql @pitch.title
    end

    it "has the user as a embeded genres" do

      response_genre_names = []
      json_response[:genres].each { |x| response_genre_names << x[:name]}
      pitch_factory_genre_names = []
      @pitch.genres.each { |x| pitch_factory_genre_names << x.name }

      expect(response_genre_names).to eql pitch_factory_genre_names
    end

    it "has the user as a embeded platforms" do
      response_platform_names = []
      json_response[:platforms].each { |x| response_platform_names << x[:name]}
      pitch_factory_platform_names = []
      @pitch.platforms.each { |x| pitch_factory_platform_names << x.name }

      expect(response_platform_names).to eql pitch_factory_platform_names
    end

    it "has the user as a embeded object" do
      pitch_response = json_response
      expect(pitch_response[:user][:email]).to eql @pitch.user.email
    end

    it { should respond_with 200 }
  end



  describe "GET #show errors" do
    before(:each) do
      @user = FactoryGirl.create :user, is_dev: false
      @pitch = FactoryGirl.create :pitch, user_id: @user.id
      api_authorization_header @pitch.user.auth_token
      get :show, params: { user_id: (@user.id + 3), id: @pitch.id }
    end

    it "when pitches don't belong to you" do
      pitch_response = json_response
      expect(pitch_response[:errors]).to eql "Sorry, this pitch does not belong to you"
    end


    it { should respond_with 422 }
  end




  describe "GET #index as Dev" do
    before(:each) do
      @user = FactoryGirl.create :user
      4.times { FactoryGirl.create :pitch, user: @user }
      api_authorization_header @user.auth_token
      get :index, params: { user_id: @user.id }
    end

    it "returns 4 records from the database" do
      pitches_response = json_response
      expect(pitches_response.length).to eq(4)
    end

    it "returns the user object into each pitch" do
      pitches_response = json_response
      pitches_response.each do |pitch_response|
        expect(pitch_response[:user]).to be_present
      end
    end

    it { should respond_with 200 }
  end

    context "when pitch_ids parameter is sent" do
      before(:each) do
        @user = FactoryGirl.create :user
        3.times { FactoryGirl.create :pitch, user: @user }
        api_authorization_header @user.auth_token
        get :index, params: { user_id: @user.id, pitch_ids: @user.pitch_ids }
      end

      it "returns just the pitchs that belong to the user" do
        pitches_response = json_response
        pitches_response.each do |pitch_response|
          expect(pitch_response[:user][:email]).to eql @user.email
        end
      end
    end
















  describe "GET #index as Influencer" do
    before(:each) do
      @user = FactoryGirl.create :user, is_dev: false
      4.times { FactoryGirl.create :pitch, user: @user }
      api_authorization_header @user.auth_token
      get :index, params: { user_id: @user.id }
    end

    it "returns 4 records from the database" do
      pitches_response = json_response
      expect(pitches_response[:errors]).to eq "Sorry, only developers can own pitches"
    end



    it { should respond_with 422 }
  end









  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @pitch_attributes = FactoryGirl.attributes_for :pitch
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, pitch: @pitch_attributes }
      end

      it "renders the json representation for the pitch record just created" do
        pitch_response = json_response
        expect(pitch_response[:title]).to eql @pitch_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_pitch_attributes = { title: "Smart TV", body: 3456 }
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, pitch: @invalid_pitch_attributes }
      end

      it "renders an errors json" do
        pitch_response = json_response
        expect(pitch_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        pitch_response = json_response
        expect(pitch_response[:errors][:expected_release_date]).to include "can't be blank"
      end

      # it "renders the json errors on why the user could not be created" do
      #   pitch_response = json_response
      #   # puts json_response
      #   # puts @pitch
      #   p pitch_response
      #   expect(pitch_response[:errors][:body]).to include "must be text (String)"
      # end

      it { should respond_with 422 }
    end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @pitch = FactoryGirl.create :pitch, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @pitch.id,
              pitch: { title: "An expensive TV" } }
      end

      it "renders the json representation for the updated user" do
        pitch_response = json_response
        expect(pitch_response[:title]).to eql "An expensive TV"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @pitch.id,
              pitch: { expected_release_date: "two hundred" } }
      end

      it "renders an errors json" do
        pitch_response = json_response
          # p json_response
        expect(pitch_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        pitch_response = json_response
        expect(pitch_response[:errors][:expected_release_date]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @pitch = FactoryGirl.create :pitch, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, params: { user_id: @user.id, id: @pitch.id }
    end

    it { should respond_with 204 }
  end

  describe ".filter_by_title" do
    before(:each) do
      @pitch1 = FactoryGirl.create :pitch, title: "A plasma TV"
      @pitch2 = FactoryGirl.create :pitch, title: "Fastest Laptop"
      @pitch3 = FactoryGirl.create :pitch, title: "CD player"
      @pitch4 = FactoryGirl.create :pitch, title: "LCD TV"

    end

    context "when a 'TV' title pattern is sent" do
      it "returns the 2 pitchs matching" do
        # puts Pitch.filter_by_title("TV")
        expect(Pitch.filter_by_title("TV").length).to eq(2)#).to have(2).items
      end

      it "returns the pitchs matching" do
        expect(Pitch.filter_by_title("TV").sort).to match_array([@pitch1, @pitch4])
      end
    end
  end


  describe ".filter_by_genre" do
    before(:each) do
      @genre1 = FactoryGirl.create :genre
      @genre2 = FactoryGirl.create :genre
      @genre3 = FactoryGirl.create :genre
      @genre4 = FactoryGirl.create :genre

      @pitch1 = FactoryGirl.create :pitch
      @pitch2 = FactoryGirl.create :pitch
      @pitch3 = FactoryGirl.create :pitch
      @pitch4 = FactoryGirl.create :pitch

      @pitch1.genres = [@genre1, @genre2]
      @pitch2.genres = [@genre3, @genre2]
      @pitch3.genres = [@genre4, @genre3]
      @pitch4.genres = [@genre1]

    end

    context "when a genre pattern is sent" do
      it "returns the 2 pitchs matching" do

        # puts "PITCH 1"
        # p @pitch1.genres.each { |g| p g.name }
        # puts "PITCH 2"
        # p @pitch2.genres.each { |g| p g.name }
        # puts "PITCH 3"
        # @pitch3.genres.each { |g| p g.name }
        # puts "PITCH 4"
        # @pitch4.genres.each { |g| p g.name }
        expect(Pitch.filter_by_genre_id(@genre1.id).length).to eq(2)
      end

      it "returns the pitchs matching" do
        expect(Pitch.filter_by_genre_id(@genre1.id).sort).to match_array([@pitch1, @pitch4])
      end
    end
  end


  describe ".filter_by_platform" do
    before(:each) do
      @platform1 = FactoryGirl.create :platform
      @platform2 = FactoryGirl.create :platform
      @platform3 = FactoryGirl.create :platform
      @platform4 = FactoryGirl.create :platform
      @pitch1 = FactoryGirl.create :pitch
      @pitch2 = FactoryGirl.create :pitch
      @pitch3 = FactoryGirl.create :pitch
      @pitch4 = FactoryGirl.create :pitch

      @pitch1.platforms = [@platform1, @platform2]
      @pitch2.platforms = [@platform3, @platform2]
      @pitch3.platforms = [@platform4, @platform3]
      @pitch4.platforms = [@platform1]

    end

    context "when a genre pattern is sent" do
      it "returns the 2 pitchs matching" do

        expect(Pitch.filter_by_platform_id(@platform1.id).length).to eq(2)
      end

      it "returns the pitchs matching" do
        expect(Pitch.filter_by_platform_id(@platform1.id).sort).to match_array([@pitch1, @pitch4])
      end
    end
  end


  describe ".filter_by_website" do
    before(:each) do
      @pitch1 = FactoryGirl.create :pitch, website: "www.testing.com"
      @pitch2 = FactoryGirl.create :pitch, website: "www.somthing.co.uk"
      @pitch3 = FactoryGirl.create :pitch, website: "www.testing.com"
      @pitch4 = FactoryGirl.create :pitch, website: "www.api.testing.com"

    end

    context "when a 'testing.com' website pattern is sent" do
      it "returns the 3 pitchs matching" do
        # puts Pitch.filter_by_title("TV")
        expect(Pitch.filter_by_website("testing.com").length).to eq(3)#).to have(2).items
      end

      it "returns the pitchs matching" do
        expect(Pitch.filter_by_website("testing.com").sort).to match_array([@pitch1, @pitch3, @pitch4])
      end
    end
  end


  describe ".above_or_equal_to_expected_release_date" do
    before(:each) do
      @pitch1 = FactoryGirl.create :pitch, expected_release_date: [*1000..2000].sample.days.from_now
      @pitch2 = FactoryGirl.create :pitch, expected_release_date: [*2..999].sample.days.from_now
      @pitch3 = FactoryGirl.create :pitch, expected_release_date: [*1500..2000].sample.days.from_now
      @pitch4 = FactoryGirl.create :pitch, expected_release_date: [*1000..2000].sample.days.from_now
    end

    it "returns the pitchs which are above or equal to the expected_release_date" do
      expect(Pitch.above_or_equal_to_expected_release_date(1000.days.from_now).sort).to match_array([@pitch1, @pitch3, @pitch4])
    end
  end

  describe ".recent" do
    before(:each) do
      @pitch1 = FactoryGirl.create :pitch
      @pitch2 = FactoryGirl.create :pitch
      @pitch3 = FactoryGirl.create :pitch
      @pitch4 = FactoryGirl.create :pitch


      #we will touch some pitchs to update them
      @pitch2.touch
      @pitch3.touch
    end

    it "returns the most updated records" do
      expect(Pitch.recent).to match_array([@pitch3, @pitch2, @pitch4, @pitch1])
    end
  end


describe ".search" do
    before(:each) do
      
      @platform1 = FactoryGirl.create :platform
      @platform2 = FactoryGirl.create :platform
      @platform3 = FactoryGirl.create :platform
      @platform4 = FactoryGirl.create :platform

      @genre1 = FactoryGirl.create :genre
      @genre2 = FactoryGirl.create :genre
      @genre3 = FactoryGirl.create :genre
      @genre4 = FactoryGirl.create :genre
      
      @pitch1 = FactoryGirl.create :pitch, title: "Plasma tv", expected_release_date: [*1000..2000].sample.days.from_now, website: "www.testing.com"
      @pitch2 = FactoryGirl.create :pitch, title: "Videogame console", expected_release_date: [*2..999].sample.days.from_now, website: "www.somthing.co.uk"
      @pitch3 = FactoryGirl.create :pitch, title: "MP3", expected_release_date: [*1500..2000].sample.days.from_now, website: "www.testing.com"
      @pitch4 = FactoryGirl.create :pitch, title: "Laptop", expected_release_date: [*1500..2000].sample.days.from_now, website: "www.api.testing.com"
      
      @pitch1.platforms = [@platform1, @platform2]
      @pitch2.platforms = [@platform3, @platform2]
      @pitch3.platforms = [@platform4, @platform3]
      @pitch4.platforms = [@platform1]

      @pitch1.genres = [@genre1, @genre2]
      @pitch2.genres = [@genre3, @genre2]
      @pitch3.genres = [@genre4, @genre3]
      @pitch4.genres = [@genre1]

    end
# keyword, website, expected_release_date genre_keyword genre_name genre_id platform_keyword platform_name platform_id
    context "when title 'videogame' and '100' a expected_release_date are set" do
      it "returns an empty array" do
        search_hash = { keyword: "videogame", expected_release_date: 1000.days.from_now }
        expect(Pitch.search(search_hash)).to be_empty
      end
    end

    context "when title 'tv', that belongs to the second genre and the first platform" do
      it "returns the pitch1" do
        search_hash = { keyword: "tv", genre_name: @genre2.name, platform_id: @platform1.id }
        expect(Pitch.search(search_hash)).to match_array([@pitch1]) 
      end
    end

    context "when an empty hash is sent" do
      it "returns all the pitchs" do
        expect(Pitch.search({})).to match_array([@pitch1, @pitch2, @pitch3, @pitch4])
      end
    end

    context "when pitch_ids is present" do
      it "returns the pitch from the ids" do
        search_hash = { pitch_ids: [@pitch1.id, @pitch2.id]}
        expect(Pitch.search(search_hash)).to match_array([@pitch1, @pitch2])
      end
    end
  end
end


