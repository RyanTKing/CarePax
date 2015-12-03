class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :plate
      t.string :make
      t.string :model
      t.integer :year
      t.string :color
      t.string :status

      t.timestamps null: false
    end
  end
end
