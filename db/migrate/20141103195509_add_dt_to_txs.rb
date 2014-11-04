class AddDtToTxs < ActiveRecord::Migration
  def change
    add_column :txs, :dt, :datetime
  end
end
