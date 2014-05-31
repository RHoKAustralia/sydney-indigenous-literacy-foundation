class CreateExcitementPages < ActiveRecord::Migration
  def change
    create_table :excitement_pages do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
