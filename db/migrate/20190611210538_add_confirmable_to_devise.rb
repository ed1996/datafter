class AddConfirmableToDevise < ActiveRecord::Migration[5.1]
  def up
    add_index :users, :confirmation_token, unique: true
  end
end
