# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  # Tells rails that follower is a user
  belongs_to :follower, class_name: "User"

  # Tells rails that followed it a user
  belongs_to :followed, class_name: "User"

  # Insure attributes are present
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
