require 'rails_helper'

describe 'Login.' do
  let!(:student_test1) { FactoryBot.create(:user) }
  let!(:teacher_test1) { FactoryBot.create(:user, email: 'teacher_test@test.com',role: 1) }
  let!(:admin_test1) { FactoryBot.create(:user, email: 'admin_test@test.com',role: 2) }

  specify 'I can log in as a student' do
    visit '/'
    click_on 'Log in'

    fill_in 'Email', with: 'student_test@test.com'
    fill_in 'Password', with: 'Password1234'
    within(:css, 'form') { click_on 'Log in' }

    expect(page).to have_content 'Signed in successfully.'
  end

  specify 'I can log out as a student' do
    login_as student_test1
    visit '/'

    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
