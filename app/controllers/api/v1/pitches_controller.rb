class Api::V1::PitchesController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :show, :create, :update, :destroy]
  respond_to :json

  def landing_index
    respond_with Pitch.all.limit(8)
  end

  def index
    # respond_with Pitch.search(params)
    if current_user.is_dev
      if params[:user_id] == current_user.id.to_s
        respond_with Pitch.where(user_id: params[:user_id])
      else
        render json: { errors: "Sorry, you can only see your own pitches" }, status: 422
      end
    else
      render json: { errors: "Sorry, only developers can own pitches" }, status: 422
    end
  end

  def show
    if params[:user_id] == current_user.id.to_s
      respond_with Pitch.where(id: params[:id], user_id: params[:user_id]).first
    else
      render json: { errors: "Sorry, this pitch does not belong to you" }, status: 422
    end
  end


  def create
    if current_user.is_dev == true
      pitch = current_user.pitches.build(pitch_params)
      if pitch.save
        render json: pitch, status: 201, location: [:api, pitch.user] #DIDI CHECK IF YOU NEED THE LOCATION
      else
        render json: { errors: pitch.errors }, status: 422
      end
    else
      render json: { errors: "Sorry, a pitch can not be created by influencer" }, status: 422
    end
  end

  def update
    pitch = current_user.pitches.find(params[:id])
    if pitch.update(pitch_params)
      render json: pitch, status: 200, location: [:api, pitch.user]
    else
      render json: { errors: pitch.errors }, status: 422
    end
  end

  def destroy
    pitch = current_user.pitches.find(params[:id])
    pitch.destroy
    head 204
  end

  private

    def pitch_params
      params.require(:pitch).permit(:title, :body, :video, :expected_release_date, :website, :genre_tags, genre_tags_attributes: [:id, :pitch_id, :genre_id], :platform_tags, platform_tags_attributes: [:id, :pitch_id, :platform_id])#, :user_id)
    end
end

# end

