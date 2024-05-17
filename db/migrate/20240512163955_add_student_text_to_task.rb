class AddStudentTextToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :student_text, :text
  end
end
