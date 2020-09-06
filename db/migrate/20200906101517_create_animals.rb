class CreateAnimals < ActiveRecord::Migration[5.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.date :date_birth
      t.date :date_death
      t.string :category
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
