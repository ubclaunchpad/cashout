class SetDefaultAvailCredit < ActiveRecord::Migration[5.0]
    def change
        change_column_default :users, :available_credit, 10000
    end
end
