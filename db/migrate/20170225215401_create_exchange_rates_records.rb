class CreateExchangeRatesRecords < ActiveRecord::Migration[5.0]
    def change
        create_table :exchange_rates_records do |t|
            t.decimal :USD
            t.decimal :CAD
            t.decimal :EUR
            t.decimal :JPY
            t.decimal :GBP
            t.decimal :CHF
            t.decimal :AUD
            t.decimal :ZAR
            t.decimal :BTC

            t.timestamps
        end
    end
end
