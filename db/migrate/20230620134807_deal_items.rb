class DealItems < ActiveRecord::Migration[7.0]
  def change
    create_table :deal_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :deal, null: false, foreign_key: { to_table: :items }

      t.timestamps
    end

    add_index :deal_items, %i[item_id deal_id], unique: true
  end
end
