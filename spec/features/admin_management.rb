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

    context "With one existing user" do
        let!(:user) {FactoryBot.create(:user, full_name:'Test User', role: 'student',email: 'testuser@example.com')}

        specify 'Admin can edit user details' do
            visit edit_user_path(user)
            fill_in 'Full name', with: 'Updated User'
            fill_in 'Email', with: 'updateUser@example.com'
            fill_in 'Username', with: 'updateduser'
            select 'Teacher', from: 'Role'

            click_on 'Save Changes'
            expect(page).to have_content 'User was successfully updated.'
            expect(user.reload.full_name).to eq('Updated User')
        end
    end

    context "With multiple existing users" do
        let!(:user_1) {FactoryBot.create(:user, full_name:'Test User1', role: 'student', email: 'testuser1@example.com')}
        let!(:user_2) {FactoryBot.create(:user, full_name:'Test User2', role: 'student', email: 'testuser2@example.com')}

        before {visit admin_dashboard_path}

        specify 'Admin can search for a user ' do
            
        end

        specify 'Admin can delete users' do

            within(:css, "#user_#{user_1.id}") {click_on 'Delete'}
            expect(page).to have_content 'Test User2'
            expect(page).to_not have_content 'Test User1'
    
        end
        
    end
    
end
