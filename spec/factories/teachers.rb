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
FactoryBot.define do
  factory :teacher do
    username { "MyString" }
    hashed_password { "MyString" }
    full_name { "MyString" }
    email { "MyString" }
    student_id { 1 }
  end
end
