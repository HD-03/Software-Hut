# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  email                         :string           default(""), not null
#  encrypted_password            :string           default(""), not null
#  full_name                     :string           not null
#  level                         :integer          default(1), not null
#  old_enough_for_cooler_avatars :boolean          default(FALSE), not null
#  remember_created_at           :datetime
#  reset_password_sent_at        :datetime
#  reset_password_token          :string
#  role                          :integer          not null
#  unchecked_background          :boolean
#  username                      :string           not null
#  xp_needed_for_next_level      :integer          default(30), not null
#  xp_points                     :integer          default(0), not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  avatar_id                     :integer          default(1), not null
#  background_id                 :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  after_initialize :set_xp_needed_for_next_level_value
  before_validation :set_xp_needed_for_next_level_value
  has_many :taught_tasks, class_name: 'Task', foreign_key: :teacher
  has_many :studied_tasks, class_name: 'Task', foreign_key: :student

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum role: { student: 0, teacher: 1, admin: 2 }
  # Example of how to set the role when creating a user:
  #     user = User.new(email: 'student@example.com', password: 'password', role: :student)
  #     user.save
  # Example of how to retrieve a user role:
  #     user = User.find_by(email: 'student@example.com')
  #     puts user.role # Outputs 'student'
  
  
  def set_xp_needed_for_next_level_value
    max = 600   # max xp threshold which is reached at level 20
    xp = nil   # xp_needed_for_next_level

    if level >= 0 && level <= 20
      xp = 30 * level
    elsif level > 20
      xp = MAX
    else
      raise RangeError, "Level can't be below 0"
    end

    self.xp_needed_for_next_level = xp
  end

  def get_current_level_progress
    #returns a percentage
    return (xp_points/xp_needed_for_next_level.to_f * 100).round
  end

end
