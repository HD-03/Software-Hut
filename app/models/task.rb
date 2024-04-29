# == Schema Information
#
# Table name: tasks
#
#  id                :bigint           not null, primary key
#  attachment_paths  :string           default([]), is an Array
#  deadline          :datetime         not null
#  description       :text
#  name              :string           not null
#  recording_boolean :boolean          default(FALSE), not null
#  reward_xp         :integer          not null
#  status            :integer          default("todo"), not null
#  time_set          :datetime         not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  instrument_id     :bigint           default(1), not null
#  student_id        :integer          not null
#  teacher_id        :integer          not null
#
# Indexes
#
#  index_tasks_on_instrument_id  (instrument_id)
#
# Foreign Keys
#
#  fk_rails_...  (instrument_id => instruments.id)
#

class Task < ApplicationRecord
  belongs_to :teacher, -> { where(role: 1) }, class_name: 'User'
  belongs_to :student, -> { where(role: 0) }, class_name: 'User'
  belongs_to :instrument

  enum status: { todo: 0, pending: 1, completed: 2 }

  # Returns the day of the week for the deadline if it falls within the current week,
  # or nil if the deadline is not within the current week.
  #
  # @return [String, nil]
  def deadline_day_this_week
    current_week_start = Date.current.beginning_of_week(:monday) -  1.days
    current_week_end = Date.current.beginning_of_week(:monday) + 6.days
    if deadline.between?(current_week_start, current_week_end)
      deadline.strftime('%A')
    else
      nil
    end
  end

  def deadline_readable
    day = deadline.strftime('%-d')
    month = deadline.strftime('%B')
    year = deadline.strftime('%Y')

    "#{day} #{month} #{year}"
  end
end
