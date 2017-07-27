class Api::V1::UsersController < ApplicationController
   before_action :authenticate_with_token!, only: [:show, :index, :update, :destroy]
  respond_to :json

  def show
    puts '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

    puts current_user
    puts '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    respond_with User.find(params[:id])
    # respond_with User.where(is_dev: true)
  end

  def index
    # if current_user.is_dev
      respond_with User.where(is_dev: false)
    # else
    #   # head 204
    #   render json: { errors: "Sorry, only developers can see influencers" }, status: 422
    # end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user
    if user.is_dev
      if user.update(user_params)
        render json: user, status: 200, location: [:api, user]
      else
        render json: { errors: user.errors }, status: 422
      end
    else
      if user.update(influencer_params)
        render json: user, status: 200, location: [:api, user]
      else
        render json: { errors: user.errors }, status: 422
      end
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:email, :is_dev, :password, :password_confirmation, :picture)
    end

    def influencer_params
      params.require(:user).permit(:email, :is_dev, :password, :password_confirmation, :picture, :user_genre_tags, user_genre_tags_attributes: [:id, :user_id, :user_genre_id])
    end

end