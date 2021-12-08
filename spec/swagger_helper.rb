# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1.0/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API v1.0',
        version: 'v1.0'
      },
      components: {
        schemas: {
          errors_object: {
            type: :object,
            properties: {
              errors: { type: :array, items: { type: :string } }
            },
            required: ['errors']
          },
          account_full: {
            type: :object,
            properties: {
              id: { type: :integer, format: :int64 },
              balance: { type: :string },
              email: { type: :string },
              first_name: { type: :string },
              last_name: { type: :string },
              phone_number: { type: :string },
              status: { type: :string, enum: %w[unverified pending verified] },
              created_at: { type: :string, format: :date_time },
              updated_at: { type: :string, format: :date_time }
            },
            required: %w[id balance email first_name last_name phone_number status created_at updated_at]
          },
          account_partial: {
            type: :object,
            properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              email: { type: :string },
              phone_number: { type: :string }
            },
            required: %w[first_name last_name email phone_number]
          },
          money_send_transaction_full: {
            type: :object,
            properties: {
              id: { type: :integer, format: :int64 },
              amount: { type: :string },
              status: { type: :string, enum: %w[declined pending succeeded] },
              sender_id: { type: :integer, format: :int64 },
              receiver_id: { type: :integer, format: :int64 },
              created_at: { type: :string, format: :date_time },
              updated_at: { type: :string, format: :date_time }
            },
            required: %w[id amount status sender_id receiver_id created_at updated_at]
          },
          money_send_transaction_partial: {
            type: :object,
            properties: {
              amount: { type: :string },
              sender_id: { type: :integer, format: :int64 },
              receiver_id: { type: :integer, format: :int64 }
            },
            required: %w[amount sender_id receiver_id]
          }
        }
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
