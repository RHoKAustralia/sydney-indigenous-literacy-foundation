class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.binary :raw_data
      t.references :excitement_page, index: true
      t.timestamps
    end
  end
end
