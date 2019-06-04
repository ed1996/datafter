class CreateMemories < ActiveRecord::Migration[5.1]
  def change
    create_table :memories do |t|
      t.text :body
      t.string :receivers
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
