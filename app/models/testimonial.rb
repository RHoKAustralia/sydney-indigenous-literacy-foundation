class Testimonial < ActiveRecord::Base

  has_one :photo, as: :imageable 
  belongs_to :excitement_page
end
