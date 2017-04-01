class AddUserToSnapshots < ActiveRecord::Migration[5.0]
    def change
        add_reference :snapshots, :user, foreign_key: true
    end
end
