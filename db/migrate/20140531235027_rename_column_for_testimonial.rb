class RenameColumnForTestimonial < ActiveRecord::Migration
  def change
    rename_column :testimonials, :excitement_space_id, :excitement_page_id
  end
end
