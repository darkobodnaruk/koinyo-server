class AddTxidToTxs < ActiveRecord::Migration
  def change
    add_column :txs, :txid, :string
  end
end
