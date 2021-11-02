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
require 'rails_helper'

RSpec.describe Account, type: :model do
  subject(:account) { build(:account, :verified) }

  it 'has a valid factory' do
    expect(account).to be_valid
  end

  describe 'Associations' do
    it { should have_many(:money_send_transactions).class_name('MoneySendTransaction') }
    it { should have_many(:money_receive_transactions).class_name('MoneySendTransaction') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
