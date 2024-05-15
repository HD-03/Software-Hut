require 'rails_helper'

RSpec.describe BasetenRequestsController, type: :controller do
  let(:student) { create(:user) }
  let(:valid_attributes) do
    {
      student_id: student.id,
      background: 'sky',
      weather: 'sunny',
      character: 'wizard',
      expression: 'happy',
      facial_hair: 'beard',
      time_period: 'medieval',
      accessory: 'staff',
      gender: 'male'
    }
  end

  before do
    sign_in student
  end

  describe 'POST #create' do
    context 'with valid params' do

      let(:model_id) { 'sample_model_id' }
      let(:api_key) { 'sample_api_key' }
      let(:request_id) { 'sample_request_id' }

      before do
        allow_any_instance_of(BasetenRequest).to receive(:generate_avatar).and_return(request_id)
      end

      it 'creates a new BasetenRequest' do
        expect {
          post :create, params: valid_attributes
        }.to change(BasetenRequest, :count).by(1)
      end

      it 'redirects to the students path with a success notice' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(students_path)
        expect(flash[:notice]).to eq('Avatar was successfully requested.')
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { student_id: nil } }

      it 'raises ActiveRecord::RecordNotFound' do
        expect {
          post :create, params: invalid_attributes
        }.to raise_error(ActiveRecord::RecordNotFound, "Invalid student ID: ")
      end
    end

    context 'when the student is not old enough for cooler avatars' do
      let(:young_student) { create(:user, old_enough_for_cooler_avatars: false) }
      let(:valid_attributes_for_young_student) do
        {
          student_id: young_student.id,
          background: 'sky',
          weather: 'sunny',
          character: 'wizard',
          expression: 'happy',
          facial_hair: 'beard',
          time_period: 'medieval',
          accessory: 'staff',
          gender: 'male'
        }
      end

      it 'prepends "playful cartoon style" to the prompt' do
        expect_any_instance_of(BasetenRequest).to receive(:generate_avatar).with(
          Rails.application.secrets.api_key,
          Rails.application.secrets.model_id,
          "playful cartoon style, closeup portrait, 32-bit pixel art, colorful, vibrant, sky background, sunny weather, wizard male character, happy facial expression, beard, medieval, staff"
        ).and_return('request_id')
        post :create, params: valid_attributes_for_young_student
      end
    end
  end
end