class DropOldTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :tasks, force: :cascade
    drop_table :teachers, force: :cascade
    drop_table :students, force: :cascade
    drop_table :admins, force: :cascade
    drop_table :students_tasks, force: :cascade
  end
end
