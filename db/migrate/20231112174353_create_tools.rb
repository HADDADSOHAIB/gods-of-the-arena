# frozen_string_literal: true
class CreateTools < ActiveRecord::Migration[7.0]
  def change
    create_table :tools do |t|
      t.string :name
      t.references :toolable, polymorphic: true

      t.timestamps
    end
  end
end
