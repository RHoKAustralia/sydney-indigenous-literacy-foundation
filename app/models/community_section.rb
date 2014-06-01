class CommunitySection < ActiveRecord::Base

  belongs_to :excitement_page

  belongs_to :community
  has_one :photo, as: :imageable 
end
