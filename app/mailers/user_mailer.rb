class UserMailer < ActionMailer::Base
	def login(user)
		mail(to: user.email,
			from: "didiraggio@gmail.com",
			subject: "User has logged in",
			body: "the user #{user.email} has logged in the user's auth_token is #{user.auth_token}"
			)
	end
end