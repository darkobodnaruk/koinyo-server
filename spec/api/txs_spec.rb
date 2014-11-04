require 'rails_helper'

describe Api::V1::TxsController, :type => :request do
  describe "GET /txs" do
    it "returns transactions since dt" do
      @user = FactoryGirl.create(:user)
      @address = FactoryGirl.create(:address)
      @tx1 = FactoryGirl.create(:tx1, target_address_id: @address.id)
      @tx2 = FactoryGirl.create(:tx2, target_address_id: @address.id)
      @tx3 = FactoryGirl.create(:tx3, target_address_id: @address.id)
      @tx_output1 = FactoryGirl.create(:tx_output1)
      @tx_output2 = FactoryGirl.create(:tx_output2)
      @tx_output3 = FactoryGirl.create(:tx_output3)
      @tx1.tx_outputs << @tx_output1
      @tx2.tx_outputs << @tx_output2
      @tx3.tx_outputs << @tx_output3
      @address.tx_outputs << [@tx_output1, @tx_output2, @tx_output3]
      @user.addresses << @address
      @user.save
      
      @params = {access_token: @user.access_token, since_dt: (Time.now - 7.days)}
      get "api/v1/txs", @params
      
      body = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(body['status']).to eq('ok')
      expect(body['addresses'].count).to eq 1
      expect(body['addresses'].keys).to eq [@address.address]
      expect(body['addresses'][@address.address].count).to eq 2

      @params = {access_token: @user.access_token, since_dt: Time.new('2009-01-01')}
      get "api/v1/txs", @params

      body = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(body['status']).to eq('ok')
      expect(body['addresses'][@address.address].count).to eq 3
    end
  end
end
