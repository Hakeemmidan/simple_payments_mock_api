class Api::V10::MoneySendTransactionsController < ApplicationController
  def create
    sender = Account.find_by_id(money_send_transaction_params[:sender_id])
    receiver = Account.find_by_id(money_send_transaction_params[:receiver_id])

    if sender.nil? || receiver.nil?
      render json: { errors: (sender.errors.full_messages + receiver.errors.full_messages) }, status: 422
      return
    elsif money_send_transaction_params[:amount].to_f.negative?
      render json: { errors: ['Amount must be greater than 0'] }, status: 422
      return
    elsif money_send_transaction_params[:amount].to_f > sender.balance.to_f
      render json: { errors: ["Amount must be less than or equal to sender's balance"] }, status: 422
      return
    elsif %w[unverified pending].include?(sender.status)
      render json: { errors: ['Sender account cannot have an unverified or pending status'] }, status: 403
      return
    elsif %w[unverified pending].include?(receiver.status)
      render json: { errors: ['Receiver account cannot have an unverified or pending status'] }, status: 403
      return
    end

    money_send_transaction = MoneySendTransaction.create(money_send_transaction_params)

    if money_send_transaction.valid?
      sender.balance -= money_send_transaction.amount
      sender.save!
      receiver.balance += money_send_transaction.amount
      receiver.save!
      money_send_transaction.status = MoneySendTransaction.statuses[:succeeded]
      money_send_transaction.save!

      render json: money_send_transaction
    else
      money_send_transaction.status = MoneySendTransaction.statuses[:declined]
      money_send_transaction.save!

      render json: { errors: money_send_transaction.errors.full_messages }, status: 422
    end
  end

  private

  def money_send_transaction_params
    params.permit(:amount, :sender_id, :receiver_id)
  end
end
