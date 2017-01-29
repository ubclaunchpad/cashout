class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.decimal :USD, precision: 2
      t.decimal :CAD, precision: 2
      t.decimal :EUR, precision: 2
      t.decimal :JPY, precision: 2
      t.decimal :GBP, precision: 2
      t.decimal :CHF, precision: 2
      t.decimal :AUD, precision: 2
      t.decimal :ZAR, precision: 2

      t.timestamps
    end
  end
end
