class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :teacher_user_id, null: false
      t.string :name, null: false
      t.text :description
      t.datetime :time_set, null: false
      t.datetime :deadline, null: false
      t.integer :base_experience_points, null: false
      t.integer :status, null: false, default: 0
      t.string :attachment_paths, array: true, default: []
      t.boolean :recording_boolean, null: false, default: false

      t.timestamps
    end
  end
end
