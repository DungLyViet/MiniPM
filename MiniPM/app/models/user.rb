class User < ApplicationRecord
	has_secure_password

	has_many :projects, dependent: :destroy
	has_many :tasks, dependent: :destroy
	has_many :pus, dependent: :destroy

	before_save { email.downcase! }

	validates :name, presence: true, length: { minimum: 5, maximum: 50 }

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	validates :password, presence: true, length: { minimum: 3 }
	validates :password_confirmation, presence: true

	validates_confirmation_of :password

	def self.users_by_project_id(project_id)
		user_ids = "SELECT user_id FROM pus WHERE project_id = :pi"

		where("id IN (#{user_ids})", pi: project_id)
	end

	def self.users_not_in_project(project_id)
		project_user_ids = "SELECT user_id FROM pus WHERE project_id = :pi"

		where("id NOT IN (#{project_user_ids})", pi: project_id)
	end
end
