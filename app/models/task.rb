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
#  status                 :integer          default("todo"), not null
#  time_set               :datetime         not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  student_id             :integer          not null
#  teacher_id             :integer          not null
#

class Task < ApplicationRecord
  belongs_to :teacher, -> { where(role: 1) }, class_name: 'User'
  belongs_to :student, -> { where(role: 0) }, class_name: 'User'

  enum status: { todo: 0, pending: 1, completed: 2 }

  # Returns the day of the week for the deadline if it falls within the current week,
  # or nil if the deadline is not within the current week.
  #
  # @return [String, nil]
  def deadline_day_this_week
    current_week_start = Date.current.beginning_of_week
    current_week_end = Date.current.end_of_week
  
    if deadline.between?(current_week_start, current_week_end)
      deadline.strftime('%A')
    else
      nil
    end
  end

  def deadline_readable
    day = deadline.strftime('%d') + 'th'
    month = deadline.strftime('%B')
    year = deadline.strftime('%Y')

    "#{day} #{month} #{year}"
  end
end
  
