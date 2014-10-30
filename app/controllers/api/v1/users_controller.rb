module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: {message: "test"}
      end

      def register
        render json: {message: "fail"} unless params.include?('phone_number') and params.include?('address')
      end
    end
  end
end