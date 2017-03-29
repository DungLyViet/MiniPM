module SessionsHelper
	def sign_in(user)
		cookies.permanent[:user_id] = user.id
		self.current_user = user
	end

	def signed_in?
		current_user != nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_id(cookies[:user_id])
	end

	def  current_user?(user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_url
			redirect_to signin_path, notice: "Need to sign in!"
		end
	end

	def sign_out
		current_user = nil
		current_projects = nil
		cookies.delete(:user_id)
		single_project = nil
		cookies.delete(:single_project_id)

		reset_single_project
		reset_project_all_users
		reset_project_all_tasks
		reset_available_users
		reset_current_own_tasks
	end

	def redirect_back_or(address)
		redirect_to(session[:return_to] || address)
		session.delete(:return_to)
	end

	def store_url
		session[:return_to] = request.url
	end

	def current_projects=(projects)
		@current_projects = projects
	end

	def reset_current_projects
		current_projects = nil
	end

	def current_projects
		if signed_in?
			@current_projects ||= Project.where(:user_id => cookies[:user_id])
		else
			@current_projects = nil
		end	
	end

	def assign_single_project(project)
		cookies.permanent[:single_project_id] = project.id
		self.single_project = project
		reset_single_project
		reset_project_all_users
		reset_project_all_tasks
		reset_available_users
		reset_current_own_tasks
	end

	def assigned_single_project?
		single_project != nil
	end

	def single_project=(project)
		@single_project = project
	end

	def single_project
		if signed_in?
			@single_project ||= Project.find_by_id(cookies[:single_project_id])
		else
			@single_project = nil
		end
	end

	def reset_single_project
		single_project = nil
	end

	def project_all_users=(users)
		@project_all_users = users
	end

	def project_all_users
		if signed_in?
			@project_all_users ||= User.users_by_project_id(cookies[:single_project_id])
		else
			@project_all_users = nil
		end
	end

	def reset_project_all_users
		project_all_users = nil
	end

	def project_all_tasks=(tasks)
		@project_all_tasks = nil
	end

	def project_all_tasks
		if signed_in?
			@project_all_tasks ||= Task.tasks_by_project_id(cookies[:single_project_id])
		else
			@project_all_users = nil
		end
	end

	def reset_project_all_tasks
		project_all_tasks = nil
	end

	def reset_current_own_tasks
		current_own_tasks = nil
	end

	def current_own_tasks=(tasks)
		@current_own_tasks = tasks
	end

	def current_own_tasks
		if signed_in?
			@current_own_tasks ||= Task.tasks_by_user_id(cookies[:user_id])
		else
			@current_own_tasks = nil
		end
	end

	def reset_available_users
		available_users = nil
	end

	def available_users=(users)
		@available_users = users
	end

	def available_users
		if signed_in?
			@available_users ||= User.users_not_in_project(cookies[:single_project_id])
		else
			@available_users = nil
		end
	end

	def identify_pu_id(pu_user_id)
		pu = Pu.pu_by_user_project_ids(pu_user_id, cookies[:single_project_id])

		pu.length > 0 ? pu.first.id : -1;
	end
end
