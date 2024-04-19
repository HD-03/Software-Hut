# == Schema Information
#
# Table name: tasks
#
#  id                     :bigint           not null, primary key
#  attachment_paths       :string           default([]), is an Array
#  base_experience_points :integer          not null
#  deadline               :datetime         not null
#  description            :text
#  name                   :string           not null
#  recording_boolean      :boolean          default(FALSE), not null
#  status                 :integer          default(0), not null
#  time_set               :datetime         not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  student_user_id        :integer          not null
#  teacher_user_id        :integer          not null
#
class Task < ApplicationRecord
    has_many :students_tasks
    has_many :students, through: :students_tasks
    belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_user_id'
    belongs_to :student, class_name: 'User', foreign_key: 'student_user_id'
  end

  
  
