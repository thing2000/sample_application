# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base
  
  # Attributes that will be editable by outside
  attr_accessible :content

  # Tells rails that micropost have a belongs to relationship to the user
  belongs_to :user

  # Insure that the content must be present but not over 140 charaters
  validates :content, presence: true, length: { maximum: 140 }

  # Insures presence ot user_id
  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'

end
