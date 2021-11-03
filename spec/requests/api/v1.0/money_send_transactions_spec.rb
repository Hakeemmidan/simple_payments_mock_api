require 'swagger_helper'

RSpec.describe 'api/v1.0/money_send_transactions', type: :request do
  describe 'MoneySendTransaction v1.0 API' do
    path '/api/v1.0/money_send_transactions' do
      post 'Creates a transaction' do
        tags 'Money Send Transactions'
        consumes 'application/json'
        parameter name: :money_send_transaction, in: :body, schema: {
          '$ref' => '#/components/schemas/money_send_transaction_partial'
        }

        response '200', 'Transaction created' do
          schema '$ref' => '#/components/schemas/money_send_transaction_full'
          examples 'application/json' => {
            'id' => 1,
            'amount' => '3.01',
            'status' => 'succeeded',
            'created_at' => '2020-01-01T00:00:00.000Z',
            'updated_at' => '2020-01-01T00:00:00.000Z',
            'sender_id' => 1,
            'receiver_id' => 2
          }
          let(:verified_sender) { create(:account, :verified) }
          let(:verified_receiver) { create(:account, :verified) }
          let(:money_send_transaction) { { amount: 12.00, sender_id: verified_sender.id, receiver_id:  verified_receiver.id } }
          run_test!
        end

        response '404', 'Invalid request' do
          schema '$ref' => '#/components/schemas/errors_object'
          examples 'application/json' => {
            errors: [
              'Request is missing required parameters. Please check OpenAPI spec and see if it mathces. Contact support if this error presist despite matching OpenAPI spec.'
            ]
          }
          let(:money_send_transaction) { { amount: 12.00 } }
          run_test!
        end

        response '403', 'Forbidden: Account pending or unverified' do
          schema '$ref' => '#/components/schemas/errors_object'
          examples 'application/json' => {
            errors: [
              'Unverified and pending accounts cannot send or receive transacctions.'
            ]
          }
          let(:unverified_sender) { create(:account, :unverified) }
          let(:verified_receiver) { create(:account, :verified) }
          let(:money_send_transaction) { { amount: 12.00, sender_id: unverified_sender.id, receiver_id:  verified_receiver.id } }
          run_test!
        end
      end
    end
  end
end
