class Book < ActiveRecord::Base
  belongs_to :excitement_page
  has_one :photo, as: :imageable, :dependent => :destroy
end
