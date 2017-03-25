class CreateSnapshots < ActiveRecord::Migration[5.0]
  def change
    create_table :snapshots do |t|
      t.decimal :USD, precision: 30, scale: 2
      t.decimal :CAD, precision: 30, scale: 2
      t.decimal :EUR, precision: 30, scale: 2
      t.decimal :JPY, precision: 30, scale: 2
      t.decimal :GBP, precision: 30, scale: 2
      t.decimal :CHF, precision: 30, scale: 2
      t.decimal :AUD, precision: 30, scale: 2
      t.decimal :ZAR, precision: 30, scale: 2
      t.decimal :BTC, precision: 30, scale: 2

      t.timestamps
    end
  end
end
