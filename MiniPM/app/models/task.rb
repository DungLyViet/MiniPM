class Task < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :project, optional: true

	validates :name, presence: true, length: {minimum: 5}
	validates :description, presence: true, length: {minimum: 10}
	validates :user_id, presence: true
	validates :project_id, presence: true

	DATETIME_REGEX = /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/i

	validates :started_at, presence: true, format: { with: DATETIME_REGEX }
	validates :expired_at, presence: true, format: { with: DATETIME_REGEX }

	def self.tasks_by_project_id(project_id)
		where(:project_id => project_id)
	end

	def self.tasks_by_user_id(user_id)
		where(:user_id => user_id)
	end

	def self.tasks_by_user_project_ids(user_id, project_id)
		where("user_id = ? AND project_id = ?", user_id, project_id)
	end
end
