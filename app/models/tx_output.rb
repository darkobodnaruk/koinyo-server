class TxOutput < ActiveRecord::Base
  belongs_to :txout, class_name: :tx
  belongs_to :txin, class_name: :tx
  belongs_to :address

end
