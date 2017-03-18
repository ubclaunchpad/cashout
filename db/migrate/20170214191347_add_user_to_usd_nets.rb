class AddUserToUsdNets < ActiveRecord::Migration[5.0]
  def change
    add_reference :usd_nets, :user, foreign_key: true
  end
end
