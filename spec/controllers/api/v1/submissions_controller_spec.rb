require 'spec_helper'

describe Api::V1::SubmissionsController do

  describe "GET #index as dev" do
    before(:each) do
      current_user = FactoryGirl.create :user
      4.times { |x| FactoryGirl.create :pitch, id: x, user_id: current_user.id}
      other_user = FactoryGirl.create( :user, is_dev: false)
      api_authorization_header current_user.auth_token
      4.times { |n| FactoryGirl.create :submission, pitch_id: n, dev: current_user, influencer: other_user}
      get :index, params: { user_id: current_user.id }
    end

    it "returns 4 submission records from the user" do
      submissions_response = json_response
      expect(submissions_response.length).to eql(4)
    end

    it { should respond_with 200 }

  end

  describe "GET #index as influencer" do
    before(:each) do
      first_influencer = FactoryGirl.create(:user, is_dev: false)
      4.times { |x| FactoryGirl.create :pitch, id: x, user_id: first_influencer.id}
      dev_user = FactoryGirl.create(:user, is_dev: true)
      4.times { |x| FactoryGirl.create :pitch, id: (x + 4), user: dev_user}
      second_influencer = FactoryGirl.create(:user, is_dev: false)
      api_authorization_header first_influencer.auth_token
      4.times { |n| FactoryGirl.create :submission, pitch_id: n,  dev: first_influencer, influencer: second_influencer }
      3.times { |n| FactoryGirl.create :submission, pitch_id: (n + 4), dev: dev_user, influencer: first_influencer}
      get :index, params: { user_id: first_influencer.id }
    end

    it { should respond_with 200 }

    it "returns 3 received_submission records from the user" do
      # p json_response
      received_submissions_response = json_response[:received_submissions]
      submissions_response = json_response[:submissions]
      expect(received_submissions_response.length).to eql(3)
      expect(submissions_response.length).to eql(4)
    end

  end


  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      current_user_pitch = FactoryGirl.create :pitch, user_id: current_user.id
      other_user = FactoryGirl.create( :user, is_dev: false)
      api_authorization_header current_user.auth_token
      @submission = FactoryGirl.create :submission, pitch_id: current_user_pitch.id, dev: current_user, influencer: other_user
      get :show, params: { user_id: current_user.id, id: @submission.id }
    end

    it "returns the user submission record matching the id" do
      submission_response = json_response
      expect(submission_response[:id]).to eql @submission.id
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      other_user = FactoryGirl.create( :user, is_dev: false)
      pitch = FactoryGirl.create :pitch, user_id: current_user.id
      api_authorization_header current_user.auth_token

    
      submission_params = { pitch_id: pitch.id,   influencer_id: other_user.id }
      post :create, params: { user_id: current_user.id, submission: submission_params }
    end

    it "returns the just user submission record" do
      # p json_response
      submission_response = json_response
      
      expect(submission_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end


end