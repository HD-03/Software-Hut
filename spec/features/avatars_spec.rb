require 'rails_helper'

describe 'avatars.' do
  let(:student) { create(:user) }

  before do
    attach_12_avatars_to_user(student)

    login_as student
  end

  specify 'I have the default avatar correctly assigned to me at the start', js: true do
    visit '/students'

    avatar = find('.resize-image-dashboard')
    expect(avatar['data-avatar-id']).to eq('1')
  end

  specify 'I can visit avatars page, see all my avatars and my currently picked one', js: true do
    visit '/students/avatars'

    current_avatar = find('#current_avatar')
    expect(current_avatar['data-avatar-id']).to eq('1')

    selected_avatar = find(".selected-avatar")
    expect(selected_avatar['data-avatar-id']).to eq('1')

    # (1..12).each do |i|
    #   avatar_i = find('')
    # end


  end

end



def attach_12_avatars_to_user(user)
  (1..12).each do |i|
    filename = "image_#{i}.jpeg"
    filepath = Rails.root.join('db', 'images', filename)

    File.open(filepath) do |file|
      user.avatar.attach(io: file, filename: filename)
    end
  end
end