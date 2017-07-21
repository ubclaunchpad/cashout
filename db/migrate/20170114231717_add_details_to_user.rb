class AddDetailsToUser < ActiveRecord::Migration[5.0]
    def change
        add_column :users, :available_credit, :decimal
        add_column :users, :went_broke_at, :date
    end
end
