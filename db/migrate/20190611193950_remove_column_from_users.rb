class RemoveColumnFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :locked_at, :datetime
  end
end