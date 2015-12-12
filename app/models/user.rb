class User < ActiveRecord::Base
  before_save { self.email = email.downcase}
  VALID_NAME_REGEX = /[A-Z](\-|[a-zA-Z])*\s[A-Z](\-|[a-zA-Z])*/
  VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
  VALID_PASSWORD_REGEX= /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]*/i
  validates :name, presence: true, length: { maximum: 71},
    format: { with: VALID_NAME_REGEX }
  validates :email, presence: true, length: { maximum: 255},
    format: { with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 8},
    format: { with: VALID_PASSWORD_REGEX,
    message: "is invalid, must contain at least 1 of the following: <ul><li>Uppercase character</li><li>Lowercase character</li><li>Digit</li>"}
  validates :city, length: { maximum: 255}
  validates :gender, length: { maximum: 6}
  validates :bio, length: {maximum: 1000}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
