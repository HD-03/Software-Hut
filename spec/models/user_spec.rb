# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  email                         :string           default(""), not null
#  encrypted_password            :string           default(""), not null
#  failed_attempts               :integer          default(0), not null
#  full_name                     :string           not null
#  has_right_to_generate_avatar  :integer          default(0), not null
#  level                         :integer          default(1), not null
#  locked_at                     :datetime
#  old_enough_for_cooler_avatars :boolean          default(FALSE), not null
#  recently_leveled_up           :boolean          default(FALSE), not null
#  remember_created_at           :datetime
#  reset_password_sent_at        :datetime
#  reset_password_token          :string
#  role                          :integer          not null
#  unchecked_background          :boolean
#  unlock_token                  :string
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
        level: 10,
        xp_points: 100,
        old_enough_for_cooler_avatars: false
      )


    describe '#set_xp_needed_for_next_level_value' do
      it 'normal: updates value for xp_needed_for_next_level variable correctly' do
        expect(user.xp_needed_for_next_level).to eq 300
      end

      it 'boundary: for level 0 (raises a RangeError)' do
        user.level = 0
        user.xp_points = 0
        expect{ user.save }.to raise_error(RangeError, "Level can't be below 1")
        
        expect(user.xp_needed_for_next_level).to eq 30
      end

      it 'boundary: for level 1' do
        user.level = 1
        user.xp_points = 15
        user.save
        
        expect(user.xp_needed_for_next_level).to eq 30
      end

      it 'boundary: for level 19' do
        user.level = 19
        user.xp_points = 197
        user.save
        
        expect(user.xp_needed_for_next_level).to eq 570
      end

      it 'boundary: for level 20' do
        user.level = 20
        user.xp_points = 240
        user.save
        
        expect(user.xp_needed_for_next_level).to eq 600
      end

      it 'boundary: for level 30' do
        user.level = 30
        user.xp_points = 5
        user.save
        
        expect(user.xp_needed_for_next_level).to eq 600
      end
    end


    describe '#get_current_level_progress' do
      it 'returns current level progress percentage value' do
        user.xp_points = 100
        user.level = 10
        user.save
        expect(user.get_current_level_progress).to eq 33
      end

      it 'boundary: for level 1 and 0 xp' do
        user.xp_points = 0
        user.level = 1
        user.save
        expect(user.get_current_level_progress).to eq 0
      end
    end


    describe '#give_student_xp_points' do
      it 'returns false if user has not levelled up' do
        user.xp_points = 100
        user.level = 10
        user.save
        expect(User.give_student_xp_points(user, 50)).to eq false
      end

      it 'returns true if user has levelled up' do
        user.xp_points = 100
        expect(User.give_student_xp_points(user, 200)).to eq true
      end

      it 'updates users "xp_points" correctly when not levelled up' do
        user.xp_points = 100
        User.give_student_xp_points(user, 50)
        expect(user.xp_points).to eq 150
      end

      it 'updates users "xp_points" correctly when levelled up and should have 0 xp' do
        user.xp_points = 100
        user.level = 10
        user.save
        User.give_student_xp_points(user, 200)
        expect(user.xp_points).to eq 0
      end

      it 'updates users xp correctly when levelled up and should have more than 0 xp' do
        user.xp_points = 100
        user.level = 10
        user.save
        User.give_student_xp_points(user, 236)
        expect(user.xp_points).to eq 36
      end
    end


  end

end
