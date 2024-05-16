require 'rails_helper'

RSpec.describe AdminController, type: :controller do
    describe "GET #dashboard" do
    let!(:admin) {FactoryBot.create(:user, role:'admin')}

        context "when authenicated" do 
            before {sign_in admin}

            it "renders the 'dashboard' template" do
                get :dashboard
                expect(response).to have_http_status(:success)
            end
        end

        context "when not authenticated" do
            it "redirects to the login page" do
                get :dashboard
                expect(response).to have_http_status(:redirect)
                expect(response).to redirect_to('/users/sign_in')
            end
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