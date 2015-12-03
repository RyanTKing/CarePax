class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total
      t.integer :time
      t.integer :rating
      t.string :review

      t.timestamps null: false
    end
  end
end
