class UsersController < ApplicationController
	include UsersHelper

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			render 'signed_up_success'
		else
			render 'new'
		end
	end

	def edit
		@user = User.find_by_id(params[:id])
	end

	def update
		@user = User.find_by_id(params[:id])

		if @user != nil && @user.update_attributes(user_params)
			redirect_to profile_path
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy

		redirect_to root_path
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
