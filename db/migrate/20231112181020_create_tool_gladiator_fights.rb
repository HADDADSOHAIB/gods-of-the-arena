# frozen_string_literal: true
class CreateToolGladiatorFights < ActiveRecord::Migration[7.0]
  def change
    create_table :tool_gladiator_fights do |t|
      t.references :tool, null: false, foreign_key: { on_delete: :nullify }
      t.references :gladiator, null: false, foreign_key: { on_delete: :nullify }
      t.references :fight, null: false, foreign_key: { on_delete: :nullify }

      t.timestamps
    end

    add_index :tool_gladiator_fights, %i[gladiator_id fight_id tool_id], unique: true,
                                                                         name: 'index_t_g_fs_on_g_id_and_f_id_and_t_id'
  end
end
