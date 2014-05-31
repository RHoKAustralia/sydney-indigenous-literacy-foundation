class AddTestimonalTextToExcitimentPage < ActiveRecord::Migration
  
  def change
    add_column :excitement_pages, :testimonial_text ,:string
  end

  
end
