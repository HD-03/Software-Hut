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
FactoryBot.define do
  factory :baseten_request do
    request_id { 'sample_request_id' }
    user_id { association(:user, role: 0).id }
  end
end
