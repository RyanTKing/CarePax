class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :fname
      t.string :lname
      t.string :hometown
      t.string :gender
      t.date :dob
      t.string :bio
      t.decimal :lat
      t.decimal :lon

      t.timestamps null: false
    end
  end
end
