class Tx < ActiveRecord::Base
  self.table_name = "txs"

  has_many :tx_outputs, foreign_key: :txin_id
  has_many :tx_inputs, foreign_key: :txout_id
end
