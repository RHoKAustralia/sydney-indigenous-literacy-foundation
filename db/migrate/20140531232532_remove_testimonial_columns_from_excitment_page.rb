class RemoveTestimonialColumnsFromExcitmentPage < ActiveRecord::Migration
  def change
    remove_column :excitement_pages, :testimonial_text
  end
end
