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
FactoryBot.define do
  factory :money_send_transaction do
    amount { Faker::Number.decimal(2) }
    status { Transaction.statuses[:pending] }
  end
end
