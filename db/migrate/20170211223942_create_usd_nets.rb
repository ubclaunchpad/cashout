class CreateUsdNets < ActiveRecord::Migration[5.0]
  def change
    create_table :usd_nets do |t|
      t.decimal :net

      t.timestamps
    end
  end
end
