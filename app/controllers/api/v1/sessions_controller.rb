class Api::V1::SessionsController < ApplicationController

  # def is_signed_in? #DIDI CHEC FOR AUTHORIZATION
  #   if user_signed_in?
  #     render :json => {"signed_in" => true, "user" => current_user}.to_json()
  #   else
  #     render :json => {"signed_in" => false}.to_json()
  #   end
 
  # end

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user && user.valid_password?(user_password)
      sign_in user, store: false #DIDI CHECK IF NEEDED STORE FALSE
      user.generate_authentication_token!

      # puts sign_in(user)
      puts current_user
      # current_user = user
      # puts current_user.save(validate: false)
      # puts "SEE IF I SAVE THE MOTHERFUCKING USER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      # puts 'the user'
      # puts user
      # puts 'is signed in?'
      # puts user_signed_in?
      # puts current_user
            # puts '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

      # puts user_session
      
      # puts current_user == user
      # puts '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
      user.save
      render json: user, status: 200, location: [:api, user]
      # UserMailer.login(user).deliver #DIDI UPDATE MAILER
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    if user = User.where(auth_token: request.headers["Authorization"], id: params[:id]).first
      # p '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      # p 'auth_token'
      # p params[:id]
      # p user
      # p request.headers["Authorization"]
      user.generate_authentication_token!
      user.save
      head 204
    else
      render json: { errors: "Sorry, but you are not authorized" }, status: 422
    end
  end

end