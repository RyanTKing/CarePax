class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
