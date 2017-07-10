class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  has_many :orders

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :password, confirmation: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  def self.ignore_case(email)
    User.where("lower(email) = ?", email.downcase)
  end

end
