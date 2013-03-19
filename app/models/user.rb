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

  # Tells rails that users has a foreign key relation ship with relationship's
  # follower_id. If user is destroyed then the relationship goes with it.
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  # Replace default name followeds to followed_users, and tells rails
  # that the relationship is through followed.
  has_many :followed_users, through: :relationships, source: :followed

  # Create a virtual table that reversed the relationship key
  # structure making followed_id the foreign key
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy

  # Creates a relationship with follower and following through the
  # virtual table reverse_relationship.
  has_many :followers, through: :reverse_relationships, source: :follower

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
    Micropost.from_users_followed_by(self)
  end

  # Checks to see if user to be followed exist in database
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  # Creates a relationship between followed and follows
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # Destroy relationship with user and other_user
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
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
