class CreateCommunitySections < ActiveRecord::Migration
  def change
    create_table :community_sections do |t|
      t.integer :excitement_page_id
      t.string :community_text
      t.integer :community_id

      t.timestamps
    end
  end
end
