# frozen_string_literal: true
class CreateWeapons < ActiveRecord::Migration[7.0]
  def change
    create_table :weapons do |t|
      t.integer :attack_points, default: 0, null: false

      t.timestamps
    end
  end
end
