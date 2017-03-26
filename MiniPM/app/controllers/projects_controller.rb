class ProjectsController < ApplicationController
	include ProjectsHelper
	include SessionsHelper

	def new
		@project = Project.new
		@project.user = current_user
	end

	def create
		@project = Project.new(project_params)
		@project.user = current_user

		if @project.save
			flash[:success] = "Project created successfully"

			redirect_to profile_path
		else
			render 'new'
		end
	end

	def update 
		@project = Project.find_by_id(params[:id])
		@project.user = current_user

		if @project.update_attributes(project_params)
			reset_current_projects

			redirect_to listprojects_path
		else
			flash.now[:error] = "Something is wrong"

			render 'edit'
		end
	end

	def destroy
		project = Project.find_by_id(params[:id])

		if project != nil
			project.destroy

			reset_current_projects
		else 
			flash[:error] = "Something is wrong"
		end

		redirect_to listprojects_path
	end

	def edit
		@project = Project.find_by_id(params[:id])
		@project.user = current_user
	end

	private

	def project_params
		params.require(:project).permit(:user_id, :name, :description)
	end
end
