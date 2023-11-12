class AddExperiencePointToGladiator < ActiveRecord::Migration[7.0]
  def change
    add_column :gladiators, :experience_points, :integer, default: 0, null: false
  end
end
