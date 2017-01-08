class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.decimal :value
      t.datetime :date_time
      t.integer :start_currency
      t.integer :end_currency
      t.decimal :fx_rate

      t.timestamps
    end
  end
end
