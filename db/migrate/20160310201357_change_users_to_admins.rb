class ChangeUsersToAdmins < ActiveRecord::Migration
  def change
    rename_table :users, :admins
  end
end
