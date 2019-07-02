class CreateRecipientsMemories < ActiveRecord::Migration[5.1]
  def change
    create_table :recipients_memories do |t|
      t.string :recipient
      t.references :memory, foreign_key: true
      t.string :status
    end
  end
end
