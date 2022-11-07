class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :user, index: true, foreign_key: true
      t.date       :buy_at
      t.string     :category_name
      t.float      :price
      t.text       :description
      t.timestamps
    end
  end
end
