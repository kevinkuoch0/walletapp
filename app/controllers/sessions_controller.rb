class SessionsController < ApplicationController

	def create
		@user = User.find_by(email: params[:email])
		if @user and @user.password == params[:password]
			flash[:notice] = "Successfully logged in!"
			session[:id] = @user.id
		else
			flash[:alert] = "Incorrect login information."
		end
		redirect_to root_path
	end	

	def destroy
		session[:id] = nil
		flash[:notice] = "You have logged out successfully!"
		redirect_to root_path
	end

end

