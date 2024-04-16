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
#  student          :integer          not null
#  teacher          :integer          not null
#  time_set         :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (student => users.id)
#  fk_rails_...  (teacher => users.id)
#

class Task < ApplicationRecord
  belongs_to :teacher, -> { where(role: 1) }, class_name: 'User'
  belongs_to :student, -> { where(role: 0) }, class_name: 'User'

  enum status: { todo: 0, pending: 1, completed: 2 }

  def deadline_day
    deadline.strftime('%A')
  end
end
  
