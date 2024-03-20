# == Schema Information
#
# Table name: teachers
#
#  id              :bigint           not null, primary key
#  email           :string
#  full_name       :string
#  hashed_password :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  student_id      :integer
#
require 'rails_helper'

RSpec.describe Teacher, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
