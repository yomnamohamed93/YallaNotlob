class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
      t.string :item
      t.integer :amount
      t.float :price
      t.text :comment

      t.timestamps
    end
  end
end
