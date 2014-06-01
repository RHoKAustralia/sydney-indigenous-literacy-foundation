class FixUpColumnsForExcitmentPage < ActiveRecord::Migration
  def change
    rename_column :excitement_pages, :text, :intro_text
    add_column :excitement_pages, :summary_text ,:string
  end
end
