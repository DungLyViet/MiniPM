module TasksHelper
	TASK_STATUS_ASSIGN = 1
	TASK_STATUS_DOING = 2
	TASK_STATUS_DONE = 4

	def status_to_s(status)
		if status == TASK_STATUS_ASSIGN
			"Assign"
		elsif status == TASK_STATUS_DOING
			"Doing"
		else
			"Done"
		end
	end
end
