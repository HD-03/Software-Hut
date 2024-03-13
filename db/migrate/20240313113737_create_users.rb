class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :hashed_pw, null: false
      t.string :name
      t.column :role, :integer, null: false, default: 0
      t.integer :unlocked_avatar_ids, array: true, default: []
      t.integer :unlocked_background_ids, array: true, default: []
      t.integer :level, null: false, default: 1
      t.integer :current_experience_points, null: false, default: 0
      t.integer :level_up_required_points, null: false, default: 0
      t.boolean :mature, null: false, default: false
  
      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
