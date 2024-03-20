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
FactoryBot.define do
  factory :student do
    username { "MyString" }
    hashed_password { "MyString" }
    full_name { "MyString" }
    email { "MyString" }
    avatar_id { 1 }
    background_id { 1 }
    unchecked_background { false }
    level { 1 }
    xp_points { 1 }
    reward_points { 1 }
    membership { false }
  end
end
