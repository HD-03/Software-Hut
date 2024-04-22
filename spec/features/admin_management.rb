require 'rails_helper'

describe 'Admin management' do
    let!(:admin) {FactoryBot.create(:user, role: 'admin')}

    before {login_as admin}

    specify 'Admin can add a student' do
      visit new_add_user_path
      fill_in 'Full name', with: 'Alice Wonderland'
      fill_in 'Email', with: 'alice@example.com'
      fill_in 'Username', with: 'alice123'
      fill_in 'Password', with: 'securepassword!'
      select 'Student', from: 'Role'
      check 'Old enough for cooler avatars?'
      click_button 'Add User'
      expect(page).to have_content 'User was successfully created'
      expect(User.last.role).to eq('student')
    end

    specify 'Admin can add a teacher' do
        visit new_add_user_path
        fill_in 'Full name', with: 'Bob Builder'
        fill_in 'Email', with: 'bob@example.com'
        fill_in 'Username', with: 'bobbuilder'
        fill_in 'Password', with: 'Builder123!'
        select 'Teacher', from: 'Role'
        click_button 'Add User'

        expect(page).to have_content 'User was successfully created'
        
    end

    
end
