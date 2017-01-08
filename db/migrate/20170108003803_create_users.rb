class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.decimal :money
      t.integer :num_resets
      t.DateTime :last_reset
      t.decimal :profit
      t.references :transaction, foreign_key: true

      t.timestamps
    end
  end
end
