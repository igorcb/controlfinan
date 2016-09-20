class ChangePriceToCurrentAccount < ActiveRecord::Migration
  def change
  	change_column :current_accounts, :price, :decimal, precision: 9, scale: 2, null: false
  end
end
