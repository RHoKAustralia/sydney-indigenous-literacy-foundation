class CreateBookOrders < ActiveRecord::Migration
  def change
    create_table :book_orders do |t|

      t.timestamps
    end
  end
end
