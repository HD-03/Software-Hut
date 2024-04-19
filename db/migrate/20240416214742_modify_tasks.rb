class ModifyTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :teacher_user_id, :teacher_id
    rename_column :tasks, :student_user_id, :student_id
  end
end
