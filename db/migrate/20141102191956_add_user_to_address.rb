class AddUserToAddress < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.references :user
    end
  end
end
