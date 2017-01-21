class AddBankruptcyCountToUsers < ActiveRecord::Migration[5.0]
    def change
        add_column :users, :bankruptcy_count, :integer
    end
end
