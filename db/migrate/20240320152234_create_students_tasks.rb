class CreateStudentsTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :students_tasks do |t|
      t.references :student, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
