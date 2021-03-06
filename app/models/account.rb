# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  balance      :decimal(16, 2)   default(0.0), not null
#  email        :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  status       :integer          default("pending"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_accounts_on_email         (email)
#  index_accounts_on_phone_number  (phone_number)
#  index_accounts_on_status        (status)
#
class Account < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_number, presence: true

  enum status: {
    unverified: -1,
    pending: 0,
    verified: 1
  }, _suffix: true

  has_many :money_send_transactions,
    foreign_key: :sender_id,
    class_name: 'MoneySendTransaction',
    dependent: :nullify,
    inverse_of: :sender

  # Gets all transactions that have this account as the receiver
  has_many :money_receive_transactions,
    foreign_key: :receiver_id,
    class_name: 'MoneySendTransaction',
    dependent: :nullify,
    inverse_of: :receiver
end
