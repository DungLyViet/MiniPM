class PusController < ApplicationController
	include SessionsHelper
	include UsersHelper

	def new
		@pu = Pu.new
		@pu.user = current_user
		@pu.project = single_project
	end

	def create
		permited_params = pu_params

		@pu = Pu.new(permited_params)
		@pu.user = User.find_by_id(permited_params[:user_id])
		@pu.project = single_project

		if @pu.save
			flash[:success] = "Adding user to the project '#{single_project.name}' successfully"

			reset_project_all_users

			redirect_to listprojects_path
		else
			render 'new'
		end
	end

	def destroy
		pu = Pu.find_by_id(params[:id])

		if pu != nil
			pu.destroy

			reset_project_all_users
		else
			flash[:error] = "Could not delete the user in this project"
		end

		redirect_to listprojects_path
	end

	private

	def pu_params
		params.require(:pu).permit(:project_id, :user_id)
	end
end
