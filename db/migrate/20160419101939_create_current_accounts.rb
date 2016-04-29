class CreateCurrentAccounts < ActiveRecord::Migration
  def change
    create_table :current_accounts do |t|
      t.integer :cash_account_id, null: false
      t.integer :cost_id, null: false
      t.date :date_ocurrence, null: false
      t.integer :type_launche, null: false
      t.integer :price, precision: 10, scale: 2, null: false
      t.string :historic

      t.timestamps null: false
    end
  end
end
