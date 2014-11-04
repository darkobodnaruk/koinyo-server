class TxOutput < ActiveRecord::Base
  belongs_to :txout, class_name: :Tx
  belongs_to :txin, class_name: :Tx
  belongs_to :address

end
