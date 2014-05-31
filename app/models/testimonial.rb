class Testimonial < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true
  belongs_to :excitement_page
end
