# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  email                         :string           default(""), not null
#  encrypted_password            :string           default(""), not null
#  failed_attempts               :integer          default(0), not null
#  full_name                     :string           not null
#  level                         :integer          default(1), not null
#  locked_at                     :datetime
#  old_enough_for_cooler_avatars :boolean          default(FALSE), not null
#  recently_leveled_up           :boolean          default(FALSE), not null
#  remember_created_at           :datetime
#  reset_password_sent_at        :datetime
#  reset_password_token          :string
#  role                          :integer          not null
#  unchecked_background          :boolean
#  unlock_token                  :string
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

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end
  
  # This validates that when a user is created, everything is filled out
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  # validates :password, presence: true, length: { minimum: 8 }, confirmation: true,
  #           format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/, message: "must include at least one lowercase letter, one uppercase letter, and one digit" }
  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/, message: "must include at least one lowercase letter, one uppercase letter, and one digit" }, confirmation: true, allow_blank: true
  validates :role, presence: true
  validate :password_presence

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :lockable

  enum role: { student: 0, teacher: 1, admin: 2 }
  has_many :tasks, foreign_key: "student_id"
  # Example of how to set the role when creating a user:
  #     user = User.new(email: 'student@example.com', password: 'password', role: :student)
  #     user.save
  # Example of how to retrieve a user role:
  #     user = User.find_by(email: 'student@example.com')
  #     puts user.role  >>>  outputs 'student'

  def self.give_student_xp_points(user, xp_points_given)
    new_xp_points_count = user.xp_points + xp_points_given
    user_leveled_up = false

    if new_xp_points_count < user.xp_needed_for_next_level
      user.xp_points = new_xp_points_count
    elsif new_xp_points_count == user.xp_needed_for_next_level
      # level up student and set xp points to zero
      user.level += 1
      user_leveled_up = true
      user.xp_points = 0
    else
      # if new_xp_points_count > xp_needed_for_next_level
      # level up student and set xp points to how much more xp they got than
      # they needed to level up
      user.level += 1
      user_leveled_up = true
      user.xp_points = new_xp_points_count - user.xp_needed_for_next_level
    end

    user.recently_leveled_up = user_leveled_up
    user.save
    return user.recently_leveled_up

  end
  
  # This method is run after user object initialisation, and before_validation, which
  # includes every time before the user is updated and saved.
  # Esentially it updates the 'xp_needed_for_next_level' value every time the user
  # levels up. This is the amount of xp required to reach the next level from the
  # current one. This is determined using a function y = 30x, where x is level, and
  # y is 'xp_needed_for_next_level', this reaches a maximum of 600xp needed to level
  # up, from level 20, and then it stays constant for any higher levels
  # @params: n/a
  # @returns: n/a
  def set_xp_needed_for_next_level_value
    
    max = 600   # max xp threshold which is reached at level 20
    xp = nil   # xp_needed_for_next_level

    if level >= 1 && level <= 20
      xp = 30 * level
    elsif level > 20
      xp = max
    else
      #set it to the level 1 value, this can be changed cause idk what to best set it to
      self.xp_needed_for_next_level = 30
      raise RangeError, "Level can't be below 1"
    end

    self.xp_needed_for_next_level = xp
  end

  # @params: n/a
  # @returns [integer] users xp point progress for the level they're currently on
  def get_current_level_progress
    return (xp_points/xp_needed_for_next_level.to_f * 100).round
  end

  private

  def password_presence
    if new_record? && password.blank?
      errors.add(:password, "can't be blank")
    end
  end

end
