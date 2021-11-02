require 'swagger_helper'

RSpec.describe 'api/v1.0/accounts', type: :request do
  describe 'Accounts v1.0 API' do
    path '/accounts' do
      post "Create a new account" do
        tags 'Account'
        consumes 'application/json'
        parameter name: :account, in: :body, schema: {
          '$ref' => '#/components/schemas/account_partial'
        }

        response '201', 'Account created successfully' do
          schema '$ref' => '#/components/schemas/account_full'
          examples 'application/json' => {
            'id': 1,
            'first_name': 'hello',
            'last_name': 'world',
            'phone_number': '123',
            'email': 'hello_world@gmail.com',
            'status': 'pending',
            'created_at': '2020-01-01T00:00:00.000Z',
            'updated_at': '2020-01-01T00:00:00.000Z',
            'balance': 0.0
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

    path '/accounts/{id}' do
      get "Get Account.find(id)" do
        tags 'Account'
        consumes 'application/json'
        parameter name: :id, in: :path, schema: { type: :integer, format: :int64 }, required: true

        response '201', "Account.find(id) found" do
          schema '$ref' => '#/components/schemas/account_full'
          examples 'application/json' => {
            'id': 1,
            'first_name': 'hello',
            'last_name': 'world',
            'phone_number': '123',
            'email': 'hello_world@gmail.com',
            'status': 'pending',
            'created_at': '2020-01-01T00:00:00.000Z',
            'updated_at': '2020-01-01T00:00:00.000Z',
            'balance': 0.0
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

    path '/accounts/{id}/money_send_transactions' do
      get "Get all Account.find(id)'s money send transactions" do
        tags 'Account'
        consumes 'application/json'
        parameter name: :id, in: :path, schema: { type: :integer, format: :int64 }, required: true

        response '201', "Account.find(id)'s money send transactions fetched" do
          schema type: :object, properties: {
            data: {
              type: :array, items: {
                '$ref' => '#/components/schemas/money_send_transaction_full'
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
        tags 'Account'
        consumes 'application/json'
        parameter name: :id, in: :path, schema: { type: :integer, format: :int64 }, required: true

        response '201', "Account.find(id)'s money receive transactions fetched" do
          schema type: :object, properties: {
            data: {
              type: :array, items: {
                '$ref' => '#/components/schemas/money_send_transaction_full'
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
