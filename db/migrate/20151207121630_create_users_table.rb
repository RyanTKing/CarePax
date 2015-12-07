class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :city
      t.date :dob
      t.string :gender
      t.string :bio
    end
  end
end
