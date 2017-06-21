class User < ApplicationRecord
	has_many :articles
	before_save { self.email = email.downcase }
	validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 }
	VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: { minimum: 4, maximum: 35 }, 
				uniqueness: { case_sensitive: false }
	validates :email, presence: true, uniqueness: true, 
				length: { minimum: 4, maximum: 25 },
				format: { with: VALID_EMAIL_REGEX }

	has_secure_password
end
