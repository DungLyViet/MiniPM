class Pu < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :project, optional: true

	validates :project_id, presence: true
	validates :user_id, presence: true

	def self.pu_by_user_project_ids(user_id, project_id)
		where("user_id = ? AND project_id = ?", user_id, project_id)
	end
end
