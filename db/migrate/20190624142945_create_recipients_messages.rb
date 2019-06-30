class CreateRecipientsMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :recipients_messages do |t|
      t.string :recipient
      t.references :message, foreign_key: true
      t.string :status
    end
  end
end
