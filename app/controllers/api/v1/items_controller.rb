# frozen_string_literal: true

module Api
  module V1
    class ItemsController < Api::V1::ApiController
      before_action :set_item, only: :show

      def index
        items = ItemSerializer.new(Item.includes(:deal_items).all)

        render json: items, status: :ok
      end

      def show
        render json: ItemSerializer.new(@item), status: :ok
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end
    end
  end
end
