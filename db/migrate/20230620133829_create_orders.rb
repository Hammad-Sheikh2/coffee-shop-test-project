class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :order_total, precision: 10, scale: 2
      t.integer :status, defualt: 0, null: false

      t.timestamps
    end
  end
end
