class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :quantity
      t.string :integer

      t.timestamps null: false
    end
  end
end
