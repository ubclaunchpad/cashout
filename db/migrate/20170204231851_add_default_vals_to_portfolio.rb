class AddDefaultValsToPortfolio < ActiveRecord::Migration[5.0]
    def change
        change_column_default :portfolios, :USD, 10000
        change_column_default :portfolios, :CAD, 0
        change_column_default :portfolios, :EUR, 0
        change_column_default :portfolios, :JPY, 0
        change_column_default :portfolios, :GBP, 0
        change_column_default :portfolios, :CHF, 0
        change_column_default :portfolios, :AUD, 0
        change_column_default :portfolios, :ZAR, 0
        change_column_default :portfolios, :BTC, 0
    end
end
