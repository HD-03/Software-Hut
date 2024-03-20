# db/migrate/TIMESTAMP_remove_array_columns_from_tasks.rb

class RemoveArrayColumnsFromTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :student_user_ids
    remove_column :tasks, :subtask_ids
  end
end
