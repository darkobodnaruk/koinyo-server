FactoryGirl.define do
  factory :user do
    phone_number "38640123456"

    before(:create) do |user|
      user.addresses << FactoryGirl.build(:address)
    end
  end
end
