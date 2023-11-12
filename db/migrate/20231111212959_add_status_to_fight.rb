# frozen_string_literal: true
class AddStatusToFight < ActiveRecord::Migration[7.0]
  def change
    add_column :fights, :status, :integer, null: false, default: 0
  end
end
