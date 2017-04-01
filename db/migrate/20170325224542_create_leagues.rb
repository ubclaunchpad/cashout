class CreateLeagues < ActiveRecord::Migration[5.0]
    def change
        create_table :leagues do |t|
            t.references :users
            t.timestamps
        end

        change_table :users do |t|
            t.references :leagues
        end
    end
end
