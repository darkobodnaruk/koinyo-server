module Api
  module V1
    BITCOIN_ADDRESS_REGEX = /^[13][a-km-zA-HJ-NP-Z0-9]{26,33}$/
    INTL_PHONE_NUM_REGEX = /^\+?[1-9]{1}[0-9]{7,11}$/

    class UsersController < ApplicationController
      def index
        render json: {message: "test"}
      end

      def register
        puts("user_params: #{user_params}")

        unless user_params.include?('phone_number') and user_params.include?('address')
          render json: {status: "missing param address / phone_number"}
          return
        end

        unless user_params['address'] =~ BITCOIN_ADDRESS_REGEX
          render json: {status: "invalid param address"}
          return
        end

        unless user_params['phone_number'] =~ INTL_PHONE_NUM_REGEX
          render json: {status: "invalid param phone_number"}
          return
        end

        @user = User.create(phone_number: user_params['phone_number'])
        if @user
          if @user.addresses.create(address: user_params['address'])
            render json: {status: "ok"}, status: 201
            return
          else
            @user.destroy
          end
        end
        render json: {status: "user with this address / phone_number exists"}
      end

      def show
        @user = User.includes(:addresses).find_by(phone_number: user_params['phone_number'])
        if @user
          # KLUDGE: converting @user to json and back to ruby just tu include addresses. there's got to be a better way.
          render json: {status: "ok", user: JSON.parse(@user.to_json(include: [:addresses]))}
        else
          render json: {status: "user not found"}, status: 404
        end
      end

      private
        def user_params
          params.permit(:phone_number, :address)
        end
    end
  end
end