# == Schema Information
#
# Table name: baseten_requests
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  request_id :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_baseten_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe BasetenRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
