require 'rails_helper'

RSpec.describe 'Api::V1_0::AccountsControllers', type: :request do
  let(:account) { create(:account, :verified) }

  describe 'POST /accounts' do
    context 'when all required params are all available' do
      before do
        post '/api/v1.0/accounts', params: {
          first_name: account.first_name,
          last_name: account.last_name,
          email: account.email,
          phone_number: account.phone_number
        }
      end

      it 'returns 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'returns the correct model object' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['email']).to eq(account.email)
        expect(parsed_response_body['phone_number']).to eq(account.phone_number)
      end
    end

    context 'when missing required params' do
      before do
        post '/api/v1.0/accounts', params: { first_name: account.first_name }
      end

      it 'returns 422 status code' do
        expect(response.status).to eq(422)
      end

      it 'returns the correct error object shape' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['errors']).to be_an_instance_of(Array)
      end
    end
  end

  describe 'GET /accounts/{id}' do
    context 'when ID is valid' do
      before do
        get "/api/v1.0/accounts/#{account.id}"
      end

      it 'returns 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'returns the correct model object' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['email']).to eq(account.email)
        expect(parsed_response_body['phone_number']).to eq(account.phone_number)
      end
    end

    context 'when ID is invalid' do
      before do
        get "/api/v1.0/accounts/id-that-doesn't-exist"
      end

      it 'returns 404 status code' do
        expect(response.status).to eq(404)
      end

      it 'returns the correct error object shape' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['errors']).to be_an_instance_of(Array)
      end
    end
  end
end
