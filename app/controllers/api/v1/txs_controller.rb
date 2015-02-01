require 'bitcoin'

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

      def utxo
        addresses = current_user.addresses.map{|addr| addr.address}
        url = "#{Rails.configuration.insight_api_url}/addr/#{addresses.join(',')}/utxo"
        logger.debug("REST: GET #{url}")
        result = RestClient.get url
        result_json = JSON.parse(result)
        sum = result_json.reduce(0){|sum, utxo| sum += utxo["amount"]}

        render json: { status: "ok", amount: sum }
      end

      def server_managed
        # params['address'], params['amount']
        # Bitcoin.network = :testnet3
        include Bitcoin::Builder

        # TODO: gather unspent txouts in a smart way (is it really necessary to be smart about it?)
        res = RestClient.get "#{Rails.configuration.insight_api_url}/addr/#{params['address']}/utxo"
        utxos = JSON.parse(res)

        utxos_amount = 0
        utxos_to_use = []
        utxos.each do |utxo|
          utxos_to_use << {txid: utxo['txid'], vout: utxo['vout'], amount: utxo['amount']}
          utxos_amount += utxo['amount']
          break if utxos_amount >= params['amount'] + Rails.configuration.min_tx_fee
        end

        new_tx = build_tx do |t|
          # add the input you picked out earlier
          t.input do |i|
            i.prev_out prev_tx
            i.prev_out_index prev_out_index
            i.signature_key key
          end

          # add an output that sends some bitcoins to another address
          t.output do |o|
            o.value 50000000 # 0.5 BTC in satoshis
            o.script {|s| s.recipient "mugwYJ1sKyr8EDDgXtoh8sdDQuNWKYNf88" }
          end

          # add another output spending the remaining amount back to yourself
          # if you want to pay a tx fee, reduce the value of this output accordingly
          # if you want to keep your financial history private, use a different address
          t.output do |o|
            o.value 49000000 # 0.49 BTC, leave 0.01 BTC as fee
            o.script {|s| s.recipient key.addr }
          end
        end
        
        render json: { status: "ok", txid: "xxx"}
      end

      private
        def tx_params
          params.permit(:since_dt)
        end
    end
  end
end