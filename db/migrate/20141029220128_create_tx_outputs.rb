class CreateTxOutputs < ActiveRecord::Migration
  def change
    create_table :tx_outputs do |t|
      t.references :transaction
      t.references :address
      t.integer :amount
    end
  end
end
