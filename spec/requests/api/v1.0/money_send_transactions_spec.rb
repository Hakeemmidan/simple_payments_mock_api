require 'swagger_helper'

RSpec.describe 'api/v1.0/money_send_transactions', type: :request do
  describe 'MoneySendTransaction v1.0 API' do
    path '/money_send_transaction' do
      post 'Creates a transaction' do
        tags 'MoneySendTransaction'
        consumes 'application/json'
        parameter name: :money_send_transaction, in: :body, schema: {
          '$ref' => '#/components/schemas/money_send_transaction_request'
        }

        response '201', 'Transaction created' do
          schema '$ref' => '#/components/schemas/money_send_transaction_response'
          examples 'application/json' => {
            'id' => 1,
            'amount' => '3.01',
            'status' => 'succeeded',
            'created_at' => '2020-01-01T00:00:00.000Z',
            'updated_at' => '2020-01-01T00:00:00.000Z',
            'sender_id' => 1,
            'receiver_id' => 2
          }
          run_test!
        end

        response '422', 'Invalid request' do
          schema '$ref' => '#/components/schemas/errors_object'
          examples 'application/json' => {
            errors: [
              'Request is missing required parameters. Please check OpenAPI spec and see if it mathces. Contact support if this error presist despite matching OpenAPI spec.'
            ]
          }
          run_test!
        end

        response '403', 'Forbidden: Account pending or unverified' do
          schema '$ref' => '#/components/schemas/errors_object'
          examples 'application/json' => {
            errors: [
              'Unverified and pending accounts cannot send or receive transacctions.'
            ]
          }
          run_test!
        end
      end
    end
  end
end
