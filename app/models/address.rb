require 'bitcoin'

class Address < ActiveRecord::Base
  belongs_to :user
  has_many :tx_outputs

  before_create :generate_keys

  private

  def generate_keys
    self.privkey, self.pubkey = Bitcoin::generate_key
    self.address = Bitcoin::pubkey_to_address(pubkey)
  end
end
