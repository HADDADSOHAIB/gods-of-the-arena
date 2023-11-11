class CreateGladiators < ActiveRecord::Migration[7.0]
  def change
    create_table :gladiators do |t|
      t.string :name, null: false
      t.integer :life_points, null: false, default: 100
      t.integer :attack_points, null: false, default: 50
      t.integer :magic_points, null: false, default: 0
      t.integer :health_status, null: false, default: 0
      t.integer :age, null: false

      t.timestamps
    end
  end
end
