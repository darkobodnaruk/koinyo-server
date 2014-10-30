class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :privkey
      t.string :pubkey
      t.boolean :server_managed
    end
  end
end
