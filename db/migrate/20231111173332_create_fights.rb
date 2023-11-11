class CreateFights < ActiveRecord::Migration[7.0]
  def change
    create_table :fights do |t|
      t.text :description

      t.timestamps
    end
  end
end
