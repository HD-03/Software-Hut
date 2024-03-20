class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :username
      t.string :hashed_password
      t.string :full_name
      t.string :email
      t.integer :avatar_id
      t.integer :background_id
      t.boolean :unchecked_background
      t.integer :level
      t.integer :xp_points
      t.integer :reward_points
      t.boolean :membership

      t.timestamps
    end
  end
end
