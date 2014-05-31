class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :photo_caption
      t.string :text_block
      t.string :speaker_name
      t.string :speaker_role
      t.integer :excitement_space_id

      t.timestamps
    end
  end
end
