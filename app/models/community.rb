class Community < ActiveRecord::Base
  has_one :community_profile
end
