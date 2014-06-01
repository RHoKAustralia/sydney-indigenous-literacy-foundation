class CreateBookSections < ActiveRecord::Migration
  def change
    create_table :book_sections do |t|
      t.integer :excitement_page_id

      t.timestamps
    end
  end
end
