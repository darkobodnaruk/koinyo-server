require 'rails_helper'

describe Api::V1::UsersController, :type => :request do
  describe "POST #register" do
    before(:each) do
      @params = FactoryGirl.attributes_for(:user)
      @params[:address] = "15CPk3FqESBciBMwksZ3pjqNSa6CbpgfRK"
    end
    it "creates user" do
      post 'api/v1/users/register', @params

      expect(response.status).to eq(201)

      body = JSON.parse(response.body)
      expect(body['status']).to eq('ok')

      new_user = User.first
      expect(new_user.phone_number).to eq("38640123456")
      expect(new_user.addresses.first.address).to eq("15CPk3FqESBciBMwksZ3pjqNSa6CbpgfRK")
    end

    it "fails to create user on missing param" do
      @params.delete(:address)
      post 'api/v1/users/register', @params

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body['status']).to match(/missing param/)
    end

    it "fails to create user on invalid address" do
      @params['address'] = 'testing123'
      post 'api/v1/users/register', @params

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body['status']).to match(/invalid param/)
    end
  end

  describe "GET <phone_number>" do
    it "gets user by phone_number" do
      @user = FactoryGirl.create(:user)
      @params = {access_token: @user.access_token}

      get "api/v1/users/#{@user.phone_number}", @params
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      puts "body: #{body}"
      expect(body['status']).to eq('ok')
      expect(body['user']['addresses'][0]['address']).to eq('15CPk3FqESBciBMwksZ3pjqNSa6CbpgfRK')

      get "api/v1/users/38600000000", @params
      expect(response.status).to eq(404)
    end
  end
end