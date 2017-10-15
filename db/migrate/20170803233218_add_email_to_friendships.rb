class AddEmailToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :email, :string
  end
end
