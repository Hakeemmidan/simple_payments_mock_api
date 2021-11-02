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
require 'rails_helper'

RSpec.describe MoneySendTransaction, type: :model do
  subject(:money_send_transaction) { build(:money_send_transaction) }

  it 'has a valid factory' do
    expect(money_send_transaction).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:sender).class_name('Account') }
    it { should belong_to(:receiver).class_name('Account') }
  end

  describe 'Validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:sender) }
    it { should validate_presence_of(:receiver) }
  end
end
