class CreateGladiatorFights < ActiveRecord::Migration[7.0]
  def change
    create_table :gladiator_fights do |t|
      t.boolean :battle_won
      t.references :gladiator, null: true, foreign_key: { on_delete: :nullify }
      t.references :fight, null: true, foreign_key: { on_delete: :nullify }

      t.timestamps
    end
  end
end
