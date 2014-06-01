class ExcitementPage < ActiveRecord::Base

  has_one :photo , as: :imageable
  has_one :testimonial 

  validates_presence_of :title, :intro_text, :summary_text
end
