class Address < ActiveRecord::Base
  belongs_to :user
  has_many :tx_outputs
end
