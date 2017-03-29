module PusHelper
	def get_pu(id)
		Pu.find_by_id(id)
	end
end
