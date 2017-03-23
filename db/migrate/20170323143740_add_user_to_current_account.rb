class AddUserToCurrentAccount < ActiveRecord::Migration
  def change
    add_reference :current_accounts, :user, index: true, foreign_key: true
  end
end
