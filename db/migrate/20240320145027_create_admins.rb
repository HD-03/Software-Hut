class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :hashed_password
      t.string :full_name
      t.string :email

      t.timestamps
    end
  end
end
