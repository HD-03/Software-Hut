# == Schema Information
#
# Table name: students_tasks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#  task_id    :bigint           not null
#
# Indexes
#
#  index_students_tasks_on_student_id  (student_id)
#  index_students_tasks_on_task_id     (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#  fk_rails_...  (task_id => tasks.id)
#
class StudentsTask < ApplicationRecord
  belongs_to :student
  belongs_to :task
end
