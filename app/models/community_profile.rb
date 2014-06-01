class CommunityProfile < ActiveRecord::Base
  belongs_to :community
  has_one :photo, as: :imageable, :dependent => :destroy
end
