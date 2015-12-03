class User < ActiveRecord::Base
	before_save { self.email = email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255},
					  format: { with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: { minimum: 6}
    validates :fname, presence: true, length: { maximum: 35}
    validates :lname, presence: true, length: { maximum: 35}
    validates :hometown, length: { maximum: 255}
    validates :gender, length: { maximum: 6}
    validates :bio, length: {maximum: 1000}
end
