class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.string :from_currency
      t.string :to_currency
      t.decimal :amount_spent
      t.decimal :amount_bought
      t.decimal :exch_rate
      t.datetime :time_of_purchase
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
