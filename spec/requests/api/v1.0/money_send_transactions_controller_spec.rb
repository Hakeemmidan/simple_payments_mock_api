require 'rails_helper'

RSpec.describe "Api::V1_0::MoneySendTransactionsContrller", type: :request do
  describe 'POST /money_send_transactions' do
    let!(:unverified_sender) { create(:account, :unverified) }
    let!(:pending_sender) { create(:account, :pending) }
    let!(:verified_sender) { create(:account, :verified) }
    let!(:unverified_receiver) { create(:account, :unverified) }
    let!(:verified_receiver) { create(:account, :verified) }
    let!(:verified_sender_pre_send_amount) { verified_sender.balance.to_f }
    let!(:verified_receiver_pre_send_amount) { verified_receiver.balance.to_f }

    context 'Cannot send more than available in balance' do
      before do
        post '/api/v1.0/money_send_transactions', params: {
          sender_id: verified_sender.id,
          receiver_id: verified_receiver.id,
          amount: 10_000
        }
      end

      it 'returns a 422 response code' do
        expect(response.status).to eq(422)
      end

      it 'returns the correct error object shape' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['errors']).to be_an_instance_of(Array)
      end
    end

    context 'Cannot send a negative amount' do
      before do
        post '/api/v1.0/money_send_transactions', params: {
          sender_id: verified_sender.id,
          receiver_id: verified_receiver.id,
          amount: -123
        }
      end

      it 'returns a 422 response code' do
        expect(response.status).to eq(422)
      end

      it 'returns the correct error object shape' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['errors']).to be_an_instance_of(Array)
      end
    end

    context 'Pending accounts cannot send money' do
      before do
        post '/api/v1.0/money_send_transactions', params: {
          sender_id: pending_sender.id,
          receiver_id: verified_receiver.id,
          amount: pending_sender.balance
        }
      end

      it 'returns a 403 response code' do
        expect(response.status).to eq(403)
      end

      it 'returns the correct error object shape' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['errors']).to be_an_instance_of(Array)
      end
    end

    context 'Unverified accounts cannot send money' do
      before do
        post '/api/v1.0/money_send_transactions', params: {
          sender_id: unverified_sender.id,
          receiver_id: verified_receiver.id,
          amount: unverified_sender.balance
        }
      end

      it 'returns a 403 response code' do
        expect(response.status).to eq(403)
      end

      it 'returns the correct error object shape' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['errors']).to be_an_instance_of(Array)
      end
    end

    context 'Unverified accounts cannot receive money' do
      before do
        post '/api/v1.0/money_send_transactions', params: {
          sender_id: verified_sender.id,
          receiver_id: unverified_receiver.id,
          amount: verified_sender.balance
        }
      end

      it 'returns a 403 response code' do
        expect(response.status).to eq(403)
      end

      it 'returns the correct error object shape' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['errors']).to be_an_instance_of(Array)
      end
    end

    context 'Verified accounts can send money' do
      before do
        post '/api/v1.0/money_send_transactions', params: {
          sender_id: verified_sender.id,
          receiver_id: verified_receiver.id,
          amount: verified_sender.balance.to_f
        }
      end

      it 'reciever gets money in balance' do
        parsed_response_body = JSON.parse(response.body)
        receiver = Account.find_by_id(parsed_response_body['receiver_id'])

        expect(receiver.balance.to_f).to eq(verified_receiver_pre_send_amount + verified_sender.balance.to_f)
      end

      it 'sender gets money subtracted from balance' do
        parsed_response_body = JSON.parse(response.body)
        sender = Account.find_by_id(parsed_response_body['sender_id'])

        expect(sender.balance.to_f).to eq(0)
      end
    end
  end
end
