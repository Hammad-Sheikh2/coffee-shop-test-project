class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.decimal :tax_rate, null: false, precision: 10, scale: 2
      t.string :discount_type, null: false
      t.decimal :discount_amount, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
