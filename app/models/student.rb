# == Schema Information
#
# Table name: students
#
#  id                   :bigint           not null, primary key
#  email                :string
#  full_name            :string
#  hashed_password      :string
#  level                :integer
#  membership           :boolean
#  reward_points        :integer
#  unchecked_background :boolean
#  username             :string
#  xp_points            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  avatar_id            :integer
#  background_id        :integer
#
class Student < ApplicationRecord
    has_many :students_tasks
    has_many :tasks, through: :students_tasks
  end
  
