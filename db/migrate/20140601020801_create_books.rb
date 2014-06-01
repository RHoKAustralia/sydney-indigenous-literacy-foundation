class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.belongs_to :excitement_page, index: true
      t.string :name
      t.string :isbn
      t.timestamps
    end
  end
end
