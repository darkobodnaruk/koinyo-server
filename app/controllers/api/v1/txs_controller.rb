module Api
  module V1
    class TxsController < ApplicationController
      before_action :require_access_token

      def index
        since_dt = tx_params['since_dt'] || 0
        # puts "current_user: #{current_user}"
        # puts "current_user['addresses']: #{current_user['addresses'].to_a}"
        addresses = {}
        current_user.addresses.each do |address|
          # puts "outputs: #{address.tx_outputs.to_a}"
          addresses[address.address] = address.tx_outputs.map do |tx_output| 
            {
              txid: tx_output.txin.txid, 
              indexout: tx_output.indexout,
              dt: tx_output.txin.dt,
              amount: tx_output.amount
            }
          end.select do |tx_output|
            tx_output[:dt] >= since_dt
          end
        end
        # puts "addresses: #{addresses}"
        render json: { status: "ok", addresses: addresses }
      end

      private
        def tx_params
          params.permit(:since_dt)
        end
    end
  end
end