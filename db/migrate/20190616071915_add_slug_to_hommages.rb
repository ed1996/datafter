class AddSlugToHommages < ActiveRecord::Migration[5.1]
  def change
    add_column :hommages, :slug, :string
    add_index :hommages, :slug, unique: true
  end
end
