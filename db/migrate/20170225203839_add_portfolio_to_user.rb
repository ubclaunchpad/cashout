class AddPortfolioToUser < ActiveRecord::Migration[5.0]
    def change
        remove_column :portfolios, :user_id
        remove_column :portfolios, :index_portfolios_on_user_id

        change_table :users do |t|
            t.references :portfolio, foreign_key: true
        end

        change_table :portfolios do |t|
            t.belongs_to :user, foreign_key: true
        end
    end
end
