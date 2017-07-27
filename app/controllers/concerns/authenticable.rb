module Authenticable

  # Devise methods overwrites
  def current_api_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless user_api_signed_in?
  end

  def user_api_signed_in?
    current_api_user.present?
  end
  
end