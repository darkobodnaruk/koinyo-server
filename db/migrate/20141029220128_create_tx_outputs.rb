class CreateTxOutputs < ActiveRecord::Migration
  def change
    create_table :tx_outputs do |t|
      t.references :txout
      t.integer :indexin
      t.references :txin
      t.integer :indexout
      t.references :address
      t.integer :amount
    end
  end
end
