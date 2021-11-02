require 'swagger_helper'

RSpec.describe 'api/v1.0/accounts', type: :request do
  describe 'Accounts v1.0 API' do
    path '/accounts/{id}/money_send_transactions' do
      get "Get all Account.find(id)'s money send transactions" do
        tags 'Account_money_send'
        consumes 'application/json'
        parameter name: :id, in: :path, schema: { type: :integer, format: :int64 }, required: true

        response '201', "Account.find(id)'s money send transactions fetched" do
          schema type: :object, properties: {
            data: {
              type: :array, items: {
                '$ref' => '#/components/schemas/money_send_transaction_response'
              }
            }
          }
          examples 'application/json' => {
            data: [
              {
                'id' => 1,
                'amount' => '1.23',
                'status' => 'succeeded',
                'created_at' => '2020-01-01T00:00:00.000Z',
                'updated_at' => '2020-01-01T00:00:00.000Z',
                'sender_id' => 1,
                'receiver_id' => 2
              },
              {
                'id' => 2,
                'amount' => '45.67',
                'status' => 'declined',
                'created_at' => '2020-01-01T00:00:00.000Z',
                'updated_at' => '2020-01-01T00:00:00.000Z',
                'sender_id' => 1,
                'receiver_id' => 2
              }
            ]
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
      end
    end

    path '/accounts/{id}/money_receive_transactions' do
      get "Get all Account.find(id)'s money receive transactions" do
        tags 'Account_money_receive'
        consumes 'application/json'
        parameter name: :id, in: :path, schema: { type: :integer, format: :int64 }, required: true

        response '201', "Account.find(id)'s money receive transactions fetched" do
          schema type: :object, properties: {
            data: {
              type: :array, items: {
                '$ref' => '#/components/schemas/money_send_transaction_response'
              }
            }
          }
          examples 'application/json' => {
            data: [
              {
                'id' => 1,
                'amount' => '1.23',
                'status' => 'succeeded',
                'created_at' => '2020-01-01T00:00:00.000Z',
                'updated_at' => '2020-01-01T00:00:00.000Z',
                'sender_id' => 1,
                'receiver_id' => 2
              },
              {
                'id' => 2,
                'amount' => '45.67',
                'status' => 'declined',
                'created_at' => '2020-01-01T00:00:00.000Z',
                'updated_at' => '2020-01-01T00:00:00.000Z',
                'sender_id' => 1,
                'receiver_id' => 2
              }
            ]
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
      end
    end
  end
end