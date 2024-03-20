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
require 'rails_helper'

RSpec.describe Student, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
