class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :accountid
      t.string :latitude
      t.string :longitude
      t.references :community_profile

      t.timestamps
    end
  end
end
