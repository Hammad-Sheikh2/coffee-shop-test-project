# frozen_string_literal: true

module Api
  module V1
    class OrdersController < Api::V1::ApiController
      before_action :set_order, only: :update
      before_action :process_token

      def index
        @orders = OrderSerializer.new(@user.orders.includes(:items).all)

        render json: @orders, status: :ok
      end

      def create
        @order = @user.orders.new(order_params)

        if @order.save
          render json: OrderSerializer.new(@order), status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def update
        if @order.update(order_params)
          render json: OrderSerializer.new(@order), status: :ok
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      private

      def set_order
        @order = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit(:user_id, :status, order_items_attributes: %i[item_id quantity])
      end

      def process_token
        unless request.headers['Authorization'].present?
          return render json: { error: 'Unauthorized Request' }, status: :unauthorized
        end

        begin
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').second,
                                   Rails.application.credentials.devise_jwt_secret_key!).first

          @user = User.find(jwt_payload['sub'])
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          render json: { error: 'Invalid Token' }, status: :unauthorized
        end
      end
    end
  end
end
