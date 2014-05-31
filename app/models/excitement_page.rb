class ExcitementPage < ActiveRecord::Base

  has_one :photo , as: :imageable
  has_one :testimonial 

end
