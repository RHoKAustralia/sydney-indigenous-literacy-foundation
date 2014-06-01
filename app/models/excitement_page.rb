class ExcitementPage < ActiveRecord::Base

  has_one :photo , as: :imageable
  has_one :testimonial
  has_one :community_section
  has_many :books, dependent: :destroy

  validates_presence_of :title, :intro_text, :summary_text
end
