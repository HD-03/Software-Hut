require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "GET #dashboard" do
    let!(:student) { FactoryBot.create(:user) }

    context "when authenticated" do
      before { sign_in student }

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
end