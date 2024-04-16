class ModifyTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :teacher_user_id, :teacher
    rename_column :tasks, :student_user_id, :student
    rename_column :tasks, :base_experience_points, :reward_xp
    remove_column :tasks, :recording_boolean
    add_column :tasks, :recording_paths, :string
    add_foreign_key :tasks, :users, column: :teacher
    add_foreign_key :tasks, :users, column: :student
  end
end
