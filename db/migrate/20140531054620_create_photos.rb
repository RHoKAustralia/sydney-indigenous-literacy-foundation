class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.binary :raw_data
      t.timestamps
    end
  end
end
