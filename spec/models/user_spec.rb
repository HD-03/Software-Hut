# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  email                         :string           default(""), not null
#  encrypted_password            :string           default(""), not null
#  full_name                     :string           not null
#  level                         :integer          default(1), not null
#  old_enough_for_cooler_avatars :boolean          default(FALSE), not null
#  remember_created_at           :datetime
#  reset_password_sent_at        :datetime
#  reset_password_token          :string
#  role                          :integer          not null
#  unchecked_background          :boolean
#  username                      :string           not null
#  xp_needed_for_next_level      :integer          default(0), not null
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
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
