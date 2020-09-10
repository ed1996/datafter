class RemoveAnimalIdFromPhotos < ActiveRecord::Migration[5.1]
  def change
    remove_reference :photos, :animal, foreign_key: true
  end
end
