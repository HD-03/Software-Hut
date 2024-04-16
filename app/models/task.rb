# == Schema Information
#
# Table name: tasks
#
#  id               :bigint           not null, primary key
#  attachment_paths :string           default([]), is an Array
#  deadline         :datetime         not null
#  description      :text
#  name             :string           not null
#  recording_paths  :string
#  reward_xp        :integer          not null
#  status           :integer          default("todo"), not null
#  time_set         :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  student_id       :integer          not null
#  teacher_id       :integer          not null
#
# Foreign Keys
#
#  fk_rails_...  (student_id => users.id)
#  fk_rails_...  (teacher_id => users.id)
#

class Task < ApplicationRecord
  belongs_to :teacher, -> { where(role: 1) }, class_name: 'User'
  belongs_to :student, -> { where(role: 0) }, class_name: 'User'

  enum status: { todo: 0, pending: 1, completed: 2 }

  def deadline_day
    deadline.strftime('%A')
  end
end
  
