# == Schema Information
#
# Table name: money_send_transactions
#
#  id          :bigint           not null, primary key
#  amount      :decimal(16, 2)   not null
#  status      :integer          default("pending"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :bigint           not null
#  sender_id   :bigint           not null
#
# Indexes
#
#  index_money_send_transactions_on_receiver_id  (receiver_id)
#  index_money_send_transactions_on_sender_id    (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => accounts.id)
#  fk_rails_...  (sender_id => accounts.id)
#
class MoneySendTransaction < ApplicationRecord
  validates :amount, :status, :sender, :receiver, presence: true

  enum status: {
    declined: -1,
    pending: 0,
    succeeded: 1
  }, _suffix: true

  belongs_to :sender,
    class_name: 'Account'

  belongs_to :receiver,
    class_name: 'Account'
end
