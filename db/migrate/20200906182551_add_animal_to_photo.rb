class AddAnimalToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_reference :photos, :animal, foreign_key: true
  end
end
