# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  
  # Tells rails witch attributes in the User model
  # that is accessible. These attributes can be modified
  # by the outside world.
  attr_accessible :email, :name, :password, :password_confirmation

  # Require presence of password, ensure that they match
  # and encrypt them to the database.
  has_secure_password

  # Tells rails that users have a has_many relationship to microposts
  has_many :microposts, dependent: :destroy

  # Call back that ensures email will be lowercase
  before_save { |user| user.email = email.downcase }

  # Create a remember token before user is saved to the database
  before_save :create_remember_token

  # Ensures that the user object does not have
  # an empty name attribute before saving to the
  # database. Also checks that the length does not exceed
  # the maximum of 50 characters.
  validates :name, presence: true, length: { maximum: 50 }

  # Regular expression to define the format
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  

  # Ensures that the user object does not have
  # an empty email attribute before saving to the
  # database. Also test email against the regular expression
  # for validation. The test checks for uniqueness and is case insensitive.
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  	uniqueness: {case_sensitive: false}

  # Ensures that the password is not blank and that is is at least
  # six characters long.
  validates :password, presence: true, length: { minimum: 6 }

  # Ensures that password_confirmation exist and is not blank. 
  validates :password_confirmation, presence: true

  def feed
    # Returns all micropost for the user id
    Micropost.where("user_id = ?", id)
  end

  # private ensures it is not visible outside class
  private
    
    # method to create remember token
    def create_remember_token
      
      # Create secure urlsafe_base64 token and assign it to 
      # remember_token attribute.
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
