class Project < ApplicationRecord
	belongs_to :user, optional: true

	validates :user_id, presence: true
	validates :name, presence: true, length: { minimum: 5 }
	validates :description, presence: true, length: { minimum: 10 }
end
