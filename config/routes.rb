# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    scope 'v1.0', module: 'v1_0', as: 'v1_0' do
      resources :accounts, only: %i[show create] do
        get 'money_send_transactions'
        get 'money_receive_transactions'
      end

      resources :money_send_transactions, only: %i[create]
    end
  end
end
