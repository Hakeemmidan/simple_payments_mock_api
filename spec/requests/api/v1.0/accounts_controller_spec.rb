require 'rails_helper'

RSpec.describe 'Api::V1_0::AccountsControllers', type: :request do
  let(:sender) { create(:account, :verified) }
  let(:receiver) { create(:account, :verified) }
  let(:money_send_transaction) { create(:money_send_transaction, sender: account, receiver: receiver) }

  describe 'POST /accounts' do
    context 'when all required params are all available' do
      before do
        post '/api/v1.0/accounts', params: {
          first_name: sender.first_name,
          last_name: sender.last_name,
          email: sender.email,
          phone_number: sender.phone_number
        }
      end

      it 'returns 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'returns the correct model object' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['email']).to eq(sender.email)
        expect(parsed_response_body['phone_number']).to eq(sender.phone_number)
      end
    end

    context 'when missing required params' do
      before do
        post '/api/v1.0/accounts', params: { first_name: sender.first_name }
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
        get "/api/v1.0/accounts/#{sender.id}"
      end

      it 'returns 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'returns the correct model object' do
        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body['email']).to eq(sender.email)
        expect(parsed_response_body['phone_number']).to eq(sender.phone_number)
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

  describe 'GET /accounts/{id}/money_send_transactions' do
    context 'when ID is valid' do
      before do
        get "/api/v1.0/accounts/#{account.id}/money_send_transactions"
      end

      it 'returns 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'returns the correct model objects' do
        parsed_response_body = JSON.parse(response.body)['data']
        expect(parsed_response_body[0]['status']).to eq(money_send_transaction.status)
      end
    end

    context 'when ID is invalid' do
      before do
        get "/api/v1.0/accounts/id-that-doesn't-exist/money_send_transactions"
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

  describe 'GET /accounts/{id}/money_receive_transactions' do
    context 'when ID is valid' do
      before do
        get "/api/v1.0/accounts/#{account.id}/money_receive_transactions"
      end

      it 'returns 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'returns the correct model objects' do
        parsed_response_body = JSON.parse(response.body)['data']
        expect(parsed_response_body).to be_empty
      end
    end

    context 'when ID is invalid' do
      before do
        get "/api/v1.0/accounts/id-that-doesn't-exist/money_receive_transactions"
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
