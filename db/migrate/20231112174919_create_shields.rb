# frozen_string_literal: true
class CreateShields < ActiveRecord::Migration[7.0]
  def change
    create_table :shields do |t|
      t.integer :protection_points, default: 0, null: false

      t.timestamps
    end
  end
end
