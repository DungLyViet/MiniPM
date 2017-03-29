module UsersHelper
	def get_user_email(user_id)
		user = User.find_by_id(user_id)

		if user != nil
			user.email
		else
			"Unknown"
		end
	end

	def available_users_to_array
		if available_users != nil
			users_array = Array.new

			available_users.each { |u|
				users_array << [u.email, u.id]
			}

			users_array
		else
			Array.new
		end
	end

	def project_all_users_to_array
		if project_all_users != nil
			users_array = Array.new

			project_all_users.each { |u|
				users_array << [u.email, u.id]
			}

			users_array
		else
			Array.new
		end
	end
end
