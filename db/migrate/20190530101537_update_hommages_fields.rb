class UpdateHommagesFields < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      change_table :hommages do |h|
        h.rename :Nom, :last_name
        h.rename :Prenom, :first_name
        h.rename :date_naissance, :date_birth
        h.rename :date_deces, :date_death
        h.rename :lieu_enterrement, :burial_place
      end
    end
  end
end
