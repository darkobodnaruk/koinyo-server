class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :phone_number
      t.string :name
      t.string :access_token
      t.string :confirmation_code
      t.datetime :cc_issued_at
      t.datetime :cc_confirmed_at
      t.boolean :server_managed
    end
  end
end
