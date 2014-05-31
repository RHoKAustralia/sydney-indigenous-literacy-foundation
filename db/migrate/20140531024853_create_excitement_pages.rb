class CreateExcitementPages < ActiveRecord::Migration
  def change
    create_table :excitement_pages do |t|

      t.timestamps
    end
  end
end
