class AddBalanceToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :balance, :decimal, precision: 16, scale: 2, null: false, default: 0
  end
end
