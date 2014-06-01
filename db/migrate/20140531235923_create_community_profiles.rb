class CreateCommunityProfiles < ActiveRecord::Migration
  def change
    create_table :community_profiles do |t|
    	t.belongs_to :community, index: true
      t.references :photo, index: true
      t.string :bio

      t.timestamps
    end
  end
end
