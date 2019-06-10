class AddTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :locked_at, :datetime
    add_index :users, :confirmation_token,   unique: true
  end
end
