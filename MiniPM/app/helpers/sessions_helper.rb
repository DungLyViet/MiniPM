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
end
