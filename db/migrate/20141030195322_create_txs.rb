class CreateTxs < ActiveRecord::Migration
  def change
    create_table :txs do |t|
      t.references :target_address, index: true
    end
  end
end
