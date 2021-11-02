class Api::V10::AccountsController < ApplicationController
  def show
    account = Account.find_by_id(params[:id])

    if !account
      render json: { errors: ['Account not found'] }, status: 404
    else
      render json: account
    end
  end

  def create
    account = Account.create(account_params)

    if account.invalid?
      render json: { errors: account.errors.full_messages }, status: 422
    else
      render json: account
    end
  end

  private

  def account_params
    params.permit(:first_name, :last_name, :email, :phone_number)
  end
end
