class ModifyTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :teacher, :teacher_id
    rename_column :tasks, :student, :student_id
  end
end
