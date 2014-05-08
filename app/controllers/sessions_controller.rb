class SessionsController < ApplicationController
	def create
	  data = request.env['omniauth.auth']
	  user = User.find_or_create_by_auth(data)
	  session[:user_id] = user.id
	  redirect_to root_path, notice: "Logged in as #{user.name}"
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_path, notice: "Logged out"
	end
end