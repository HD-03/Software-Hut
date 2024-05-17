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
#  student_text      :text
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

  has_many_attached :files
  has_many_attached :recordings
  

  enum status: { todo: 0, pending: 1, completed: 2 }

  # This validates that when a task is set, everything is filled out
  validates :student_id, :instrument_id, :name, :description, :reward_xp, :deadline, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validate :at_least_one_student

  def deadline_readable
    day = deadline.strftime('%-d')
    month = deadline.strftime('%B')
    year = deadline.strftime('%Y')

    "#{day} #{month} #{year}"
  end

  private

  def at_least_one_student
    errors.add(:student_id, "can't be blank") if student_id.blank?
  end

end
