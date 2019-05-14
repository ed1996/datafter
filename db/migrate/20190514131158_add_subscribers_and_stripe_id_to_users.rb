class AddSubscribersAndStripeIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :subscribed, :boolean
    add_column :users, :stripeid, :string
  end
end
