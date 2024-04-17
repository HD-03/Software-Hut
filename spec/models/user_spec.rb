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
#  xp_needed_for_next_level      :integer          default(30), not null
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
  #pending "add some examples to (or delete) #{__FILE__}"

  context 'with_an_initialised_user' do
    user = User.new(
        email: 'student1@example.com',
        password: 'Password1234',
        password_confirmation: 'Password1234',
        role: 0, # Student role
        username: "student_username1",
        full_name: "Student Full Name 1",
        avatar_id: 1,
        level: 9,
        xp_points: 90,
        old_enough_for_cooler_avatars: false
      )

    describe '#set_xp_needed_for_next_level_value' do
      it 'updates value for xp_needed_for_next_level variable correctly' do  
        expect(user.xp_needed_for_next_level).to eq 270
      end
    end

    describe '#get_current_level_progress' do
      it 'returns current level progress percentage value' do
        expect(user.get_current_level_progress).to eq 33
      end
    end
  end

end
