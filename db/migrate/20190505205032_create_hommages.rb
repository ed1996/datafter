class CreateHommages < ActiveRecord::Migration[5.1]
  def change
    create_table :hommages do |t|
      t.string :Nom
      t.string :Prenom
      t.date :date_naissance
      t.date :date_deces
      t.string :lieu_enterrement
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
