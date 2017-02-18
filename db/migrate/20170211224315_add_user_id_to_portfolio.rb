class AddUserIdToPortfolio < ActiveRecord::Migration[5.0]
  def change
      add_reference :portfolios, :user, foreign_key: true
  end
end
