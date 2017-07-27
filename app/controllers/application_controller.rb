# class ApplicationController < ActionController::API
class ApplicationController < ActionController::Base
	# include ActionView::Layout
	include ActionController::RequestForgeryProtection
	protect_from_forgery with: :null_session
	include Authenticable
# class ApplicationController < ActionController::Base
#   protect_from_forgery with: :null_session

end
