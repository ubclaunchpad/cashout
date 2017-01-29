class RemoveTimeOfPurchase < ActiveRecord::Migration[5.0]
    def change
        remove_column :purchases, :time_of_purchase
    end
end
