class Project < ApplicationRecord
	belongs_to :user, optional: true

	has_many :tasks, dependent: :destroy
	has_many :pus, dependent: :destroy

	validates :user_id, presence: true
	validates :name, presence: true, length: { minimum: 5 }
	validates :description, presence: true, length: { minimum: 10 }

	def self.project_by_user_project_ids(user_id, project_id)
		where("id = :id AND user_id = :uid", :id => project_id, :uid => user_id)
	end
end
