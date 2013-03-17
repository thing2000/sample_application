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
  # Insures presence ot user_id
  validates :user_id, presence: true

end
