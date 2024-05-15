require 'rails_helper'

describe 'Login.' do
  let!(:student_test1) { FactoryBot.create(:user ,email: 'student_test@test.com') }
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

  context 'I am redirected to my dashboard when logging in' do
    original_wait_time = Capybara.default_max_wait_time
    puts ("original wait time:   #{original_wait_time}")
    Capybara.default_max_wait_time = 3 # seconds


    specify 'As a student' do
      visit '/'
      click_on 'Log in'

      fill_in 'Email', with: 'student_test@test.com'
      fill_in 'Password', with: 'Password1234'
      within(:css, 'form') { click_on 'Log in' }

      expect(page).to have_current_path("/students")
    end

    specify 'As a teacher' do
      visit '/'
      click_on 'Log in'

      fill_in 'Email', with: 'teacher_test@test.com'
      fill_in 'Password', with: 'Password1234'
      within(:css, 'form') { click_on 'Log in' }

      expect(page).to have_current_path("/teachers")
    end

    specify 'As a manager' do
      visit '/'
      click_on 'Log in'

      fill_in 'Email', with: 'admin_test@test.com'
      fill_in 'Password', with: 'Password1234'
      within(:css, 'form') { click_on 'Log in' }

      expect(page).to have_current_path("/admin/dashboard")
    end

    Capybara.default_max_wait_time = original_wait_time
  end

  # context 'I am flashed the correct alert for login attempts' do
  #   specify 'I am shown an error alert if I enter a non-existent e-mail' do
  #     visit '/'
  #     click_on 'Log in'

  #     fill_in 'Email', with: 'non-existent@email.com'
  #     fill_in 'Password', with: 'Password1234'
  #     within(:css, 'form') { click_on 'Log in' }

  #     save_and_open_page
  #     expect(page).to have_content "Invalid Email or Password"
  #   end

  #   specify 'I am show an error alert if I enter the wrong password' do
  #     skip
  #   end

  #   specify 'I am shown the alert "logged in" if I login successfully' do
  #     skip
  #   end
  # end
end
