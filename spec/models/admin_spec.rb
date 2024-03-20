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
require 'rails_helper'

RSpec.describe Admin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
