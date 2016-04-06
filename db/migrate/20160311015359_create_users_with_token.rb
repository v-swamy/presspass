class CreateUsersWithToken < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :device_token
      t.timestamps
    end
  end
end
