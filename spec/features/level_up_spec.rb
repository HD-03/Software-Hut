require 'rails_helper'

describe 'level_up.' do
  let!(:student) { FactoryBot.create(:user) }
  #before { login_as student }

  specify "I don't see a pop up in my student dashboard when I haven't leveled up" do
    student.recently_leveled_up = false
    login_as student
    visit '/students'
    
    expect(page).to have_selector('#levelUpModal', visible: false)
  end

  specify 'I see a pop up in my student dashboard when I level up' do
    student.recently_leveled_up = true
    login_as student
    visit '/students'

    expect(page).to have_selector('#levelUpModal', visible: :visible)
  end

  specify 'The pop up modal has the correct content (including my new level)' do
    student.recently_leveled_up = true
    login_as student
    visit '/students'

    within('#levelUpModal') do
      expect(page).to have_content("Level #{student.level} reached")
      expect(page).to have_content("New avatars unlocked:")
    end
  end

end