module ProjectsHelper
	def is_project_owner(user_id, project_id)
		Project.project_by_user_project_ids(user_id, project_id).length > 0 ? true : false
	end
end
