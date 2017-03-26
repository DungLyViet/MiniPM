class User < ApplicationRecord
	has_secure_password

	has_many :projects, dependent: :destroy

	before_save { email.downcase! }

	validates :name, presence: true, length: { minimum: 5, maximum: 50 }

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	validates :password, presence: true, length: { minimum: 3 }
	validates :password_confirmation, presence: true

	validates_confirmation_of :password
end
