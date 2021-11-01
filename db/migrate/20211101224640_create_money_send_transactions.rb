class CreateMoneySendTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :money_send_transactions do |t|
      t.decimal :amount, precision: 16, scale: 2, null: false
      t.integer :status, null: false, default: MoneySendTransaction.statuses[:pending]

      t.timestamps
    end
  end
end
