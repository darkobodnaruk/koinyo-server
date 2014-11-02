class Tx < ActiveRecord::Base
  has_many :tx_outputs
  has_many :tx_inputs

end
