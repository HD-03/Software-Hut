require 'rails_helper'

describe 'Admin management' do
    let!(:admin) {FactoryBot.create(:user, role: 'admin')}

    before {login_as admin}

    specify 'Admin can add a student' do
      visit new_add_user_path
      fill_in 'Full name', with: 'Alice Wonderland'
      fill_in 'Email', with: 'alice@example.com'
      fill_in 'Username', with: 'alice123'
      fill_in 'Password', with: 'Securepassword1!'
      fill_in 'Password confirmation', with: 'Securepassword1!'
      select 'Student', from: 'Role'
      check 'Old enough for cooler avatars?'
      click_button 'Add user'
      expect(page).to have_content 'User was successfully created'
      expect(User.last.role).to eq('student')
    end

    specify 'Admin can add a teacher' do
        visit new_add_user_path
        fill_in 'Full name', with: 'Bob Builder'
        fill_in 'Email', with: 'bob@example.com'
        fill_in 'Username', with: 'bobbuilder'
        fill_in 'Password', with: 'Builder123!'
        fill_in 'Password confirmation', with: 'Builder123!'
        select 'Teacher', from: 'Role'
        click_button 'Add user'

        expect(page).to have_content 'User was successfully created'
        
    end

    specify 'Admin can add an instrument' do
        visit new_instrument_path
        fill_in 'Name', with: 'Piccolo'
        click_button 'Add instrument'
        expect(page).to have_content 'Instrument added successfully.'
        expect(Instrument.last.name).to eq('Piccolo')
    end

    context "With one existing user" do
        let!(:user) {FactoryBot.create(:user, full_name:'Test User', role: 'student',email: 'testuser@example.com')}

        specify 'Admin can edit user details' do
            visit edit_user_admin_path(user)
            fill_in 'Full name', with: 'Updated User'
            fill_in 'Email', with: 'updateUser@example.com'
            fill_in 'Username', with: 'updateduser'
            select 'Teacher', from: 'Role'

            click_on 'Save Changes'
            expect(page).to have_content 'User was successfully updated.'
            expect(user.reload.full_name).to eq('Updated User')
        end
    end

    describe "POST #create" do
    let!(:admin) {FactoryBot.create(:user, role:'admin')}
    let!(:user) {FactoryBot.create(:user)}

    before {sign_in admin}
        context "with valid inputs" do
            it "creates a new User" do
                post :create, params: { user: { full_name: 'John Doe', email: 'john@example.com', username: 'johndoe', password: 'Secure123!', password_confirmation: 'Secure123!', role: 'student' } }
                expect(response).to redirect_to(admin_dashboard_path)
                expect(User.last.email).to eq('john@example.com')
            end
        end

        context "with invalid inputs" do
            it "does not create a user and re-renders the new template" do
                post :create, params: { user: { full_name: '' } } 
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    describe "DELETE #delete_user" do
    let!(:admin) {FactoryBot.create(:user, role:'admin')}
    let!(:user) {FactoryBot.create(:user)}

    before {sign_in admin}
        it "deletes the user and redirects to dashboard" do
            delete :delete_user, params: {id: user.id}
            expect(response).to redirect_to(admin_dashboard_path)
            expect(User.exists?(user.id)).to be_falsey
        end
    end
end