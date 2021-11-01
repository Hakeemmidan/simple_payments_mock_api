class AddSenderAndReceiverRefsToMoneySendTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :money_send_transactions, :sender, foreign_key: { to_table: :accounts }, null: false
    add_reference :money_send_transactions, :receiver, foreign_key: { to_table: :accounts }, null: false
  end
end
