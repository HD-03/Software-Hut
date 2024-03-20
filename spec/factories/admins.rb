# == Schema Information
#
# Table name: admins
#
#  id              :bigint           not null, primary key
#  email           :string
#  full_name       :string
#  hashed_password :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :admin do
    username { "MyString" }
    hashed_password { "MyString" }
    full_name { "MyString" }
    email { "MyString" }
  end
end
