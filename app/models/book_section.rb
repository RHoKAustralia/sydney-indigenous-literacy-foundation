class BookSection < ActiveRecord::Base

  belongs_to :excitement_page

  has_many :photos, as: :imageable 
end
