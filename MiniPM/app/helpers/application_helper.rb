module ApplicationHelper
	def generate_title(title)
		if title.empty?
			"MiniPM"
		else
			title
		end
	end
end
