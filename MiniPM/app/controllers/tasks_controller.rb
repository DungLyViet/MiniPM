class TasksController < ApplicationController
	include SessionsHelper
	include TasksHelper
	include ProjectsHelper

	@@project_id = -1

	def new
		@task = Task.new
		@task.user = current_user
		@task.project = single_project
	end

	def create
		permited_params = task_params

		@task = Task.new(permited_params)
		@task.user = User.find_by_id(permited_params[:user_id])
		@task.project = single_project

		if @task.save
			flash[:success] = "Add new task successfully"

			reset_project_all_tasks

			redirect_to listprojects_path
		else
			render 'new'
		end
	end

	def edit 
		@task = Task.find_by_id(params[:id])

		@@project_id = params[:project_id]

		if @task != nil
			@task.user = current_user

			if single_project == nil
				@task.project = Project.find_by_id(@@project_id)
			else 
				@task.project = single_project
			end
		end
	end

	def update
		@task = Task.find_by_id(params[:id])
		permited_params = nil

		if single_project != nil && is_project_owner(current_user.id, single_project.id)
			permited_params = params.require(:task).permit(:name, :description, :status, :started_at, :expired_at, :user_id)
		else
			permited_params = params.require(:task).permit(:name, :description, :status, :started_at, :expired_at)
		end

		if @task != nil
			@task.user = current_user

			if single_project == nil
				@task.project = Project.find_by_id(@@project_id)
			else 
				@task.project = single_project
			end

			if @task.update_attributes(permited_params)
				flash[:success] = "Update task successfully"

				redirect_to profile_path
			else
				render 'edit'
			end
		else
			render 'edit'
		end
	end

	def destroy 
		task = Task.find_by_id(params[:id])

		if task != nil
			task.destroy

			flash[:success] = "Delete task successfully"

			reset_project_all_tasks
			reset_current_own_tasks
		else
			flash[:error] = "Could not delete the task"
		end

		redirect_to profile_path
	end

	private

	def task_params
		params.require(:task).permit(:project_id, :user_id, :name, :description, :status, :started_at, :expired_at)
	end
end
