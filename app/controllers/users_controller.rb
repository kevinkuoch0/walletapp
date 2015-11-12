class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
    	@total_balance = @user.cards.sum(:balance) 
	end
 
	def edit
		@user = User.find(params[:id])
	end

  def update
    @user = User.find(params[:id])
  	if @user.update(user_params)
    	redirect_to @user, notice: "User successfully updated."
    else
      flash[:alert] = "Something went wrong."
      render :edit
    end
 end

	def new
		@user = User.new
	end

	def create
		@user = User.new(userparams)
		if @user.save
			session[:id] = @user.id
			redirect_to @user, notice: "User created!"
		else
			flash[:alert] = "User was not created successfully."
			render :new
		end			
	end


	def destroy
		if session[:id] == @user.id
			session[:id] = nil
			# @user = User.find(params[:id]).destroy
			@user.destroy
			redirect_to users_path, notice: "User deleted!"
		else
			redirect_to users_path, notice: "User was not deleted."
		end
	end

	private

	def userparams
		params.require(:user).permit(:email, :password, :password_confirmation, :fname, :lname, :phone)
	end	

end