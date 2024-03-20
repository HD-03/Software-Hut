class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.string :username
      t.string :hashed_password
      t.string :full_name
      t.string :email
      t.integer :student_id

      t.timestamps
    end
  end
end
