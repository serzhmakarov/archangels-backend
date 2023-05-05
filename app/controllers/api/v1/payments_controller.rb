class Api::V1::PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :check_admin, only: [:create, :destroy, :update]

  def create_checkout_url
    # Replace these values with your own
    merchant_id = ENV["FONDY_MERCHANT_ID"] || "1511723"
    secret_key = ENV["FONDY_PAYMENT_KEY"] || "6hiqHC4LgqjUGJc7e9rXsL8grXV9JKbq"
    amount = params[:amount].to_i * 100
    currency = params[:currency]
    order_id = Time.now.to_i # Generate a unique order ID based on the current timestamp
    order_desc = "Payment for Order ##{order_id}"

    # Calculate the signature
    # signature = Digest::SHA1.hexdigest("#{secret_key}|#{merchant_id}|#{order_id}|#{amount}|#{currency}")
    signature = Digest::SHA1.hexdigest("#{secret_key}|#{amount}|#{currency}|#{merchant_id}|#{order_desc}|#{order_id}")

    # Construct the request payload
    payload = {
      request: {
        merchant_id:,
        order_id:,
        order_desc:,
        currency:,
        amount:,
        signature:
      }
    }

    # Send the POST request to the Fondy API
    response = HTTParty.post(
      'https://pay.fondy.eu/api/checkout/url/',
      headers: { 'Content-Type' => 'application/json' },
      body: payload.to_json
    )

    checkout_url = response['response']['checkout_url']

    if checkout_url
      render json: { checkout_url: checkout_url }
    else
      render json: { error: 'Error creating Fondy checkout URL.', body: response['response'] }, status: :unprocessable_entity
    end
  end

  private

  def checkout_params
    params.permit(:amount, :currency)
  end
end
