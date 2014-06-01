class CommunitySection < ActiveRecord::Base

  belongs_to :excitement_page
  has_one :photo, as: :imageable 
end
