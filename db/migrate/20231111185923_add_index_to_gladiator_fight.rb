class AddIndexToGladiatorFight < ActiveRecord::Migration[7.0]
  def change
    add_index :gladiator_fights, [:gladiator_id, :fight_id], unique: true
  end
end
