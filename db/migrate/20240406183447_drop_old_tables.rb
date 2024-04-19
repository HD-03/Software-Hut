class DropOldTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :tasks, force: :cascade, if_exists: true
    drop_table :teachers, force: :cascade, if_exists: true
    drop_table :students, force: :cascade, if_exists: true
    drop_table :admins, force: :cascade, if_exists: true
    drop_table :students_tasks, force: :cascade, if_exists: true
  end
end
