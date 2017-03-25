class SessionsController < ApplicationController
	include SessionsHelper

	def new
		if signed_in?
			redirect_to signedin_path

			return			
		end
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)

		if user != nil && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to signedin_path
		else
			flash.now[:error] = 'Invalid email or password'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

	def profile_path

	end
end
