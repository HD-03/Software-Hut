require 'rails_helper'

describe 'settings.' do
  let!(:student) { FactoryBot.create(:user) }
  before { login_as student }
  before { visit '/users/edit' }


  specify 'I can change just my e-mail, and log in after with the new e-mail' do
    fill_in 'Email', with: 'new_email@example.com'
    fill_in 'Current password', with: 'Password1234'
    within(:css, 'form') { click_on 'Update' }

    expect(page).to have_content("Your account has been updated successfully")
    
    click_on 'Log out'
    click_on 'Log in'
    fill_in 'Email', with: 'new_email@example.com'
    fill_in 'Password', with: 'Password1234'
    within(:css, 'form') { click_on 'Log in' }

    expect(page).to have_content 'Signed in successfully.'
  end


  specify "I can't change my e-mail when the wrong current password is entered" do
    fill_in 'Email', with: 'new_email@example.com'
    fill_in 'Current password', with: 'wrong_password'
    within(:css, 'form') { click_on 'Update' }

    expect(page).to have_content("Current password is invalid")
    expect(page).to have_content("Please review the problems below:")
  end


  specify "I can change just my password, and log in after with the new password" do
    fill_in 'Password', with: 'New_password123'
    fill_in 'Password confirmation', with: 'New_password123'
    fill_in 'Current password', with: 'Password1234'
    within(:css, 'form') { click_on 'Update' }

    expect(page).to have_content("Your account has been updated successfully")
    
    click_on 'Log out'
    click_on 'Log in'
    fill_in 'Email', with: 'student_test@test.com'
    fill_in 'Password', with: 'New_password123'
    within(:css, 'form') { click_on 'Log in' }

    expect(page).to have_content 'Signed in successfully.'
  end


  specify "I can't change my password when the wrong current password is entered" do
    fill_in 'Password', with: 'New_password123'
    fill_in 'Password confirmation', with: 'New_password123'
    fill_in 'Current password', with: 'wrong_password'
    within(:css, 'form') { click_on 'Update' }

    expect(page).to have_content("Current password is invalid")
    expect(page).to have_content("Please review the problems below:")
  end


  specify "I can change my e-mail and password at the same time, and log in again with my new details" do
    fill_in 'Email', with: 'new_email@example.com'
    fill_in 'Password', with: 'New_password123'
    fill_in 'Password confirmation', with: 'New_password123'
    fill_in 'Current password', with: 'Password1234'
    within(:css, 'form') { click_on 'Update' }

    expect(page).to have_content("Your account has been updated successfully")
    
    click_on 'Log out'
    click_on 'Log in'
    fill_in 'Email', with: 'new_email@example.com'
    fill_in 'Password', with: 'New_password123'
    within(:css, 'form') { click_on 'Log in' }

    expect(page).to have_content 'Signed in successfully.'
  end


  specify "I can't change my e-mail and password at the same time when the wrong current password is enterd" do
    fill_in 'Email', with: 'new_email@example.com'
    fill_in 'Password', with: 'New_password123'
    fill_in 'Password confirmation', with: 'New_password123'
    fill_in 'Current password', with: 'wrong_password'
    within(:css, 'form') { click_on 'Update' }

    expect(page).to have_content("Current password is invalid")
    expect(page).to have_content("Please review the problems below:")
  end


end