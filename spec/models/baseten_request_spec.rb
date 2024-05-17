# == Schema Information
#
# Table name: baseten_requests
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  request_id :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_baseten_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe BasetenRequest, type: :model do
  describe 'associations' do
    it { 
      expect(BasetenRequest.reflect_on_association(:student).macro).to eq(:belongs_to)
      expect(BasetenRequest.reflect_on_association(:student).options[:class_name]).to eq('User') 
    }
  end

  describe '#generate_avatar' do
    let(:baseten_api_key) { 'your_baseten_api_key' }
    let(:model_id) { 'your_model_id' }
    let(:prompt) { 'cheerful smiling pirate, closeup portrait, 32-bit pixel art, beach background with palm trees, ocean, sand, colorful, vibrant, playful cartoon style, happy friendly expression, jaunty pirate hat, parrot on shoulder' }
    let(:request) { FactoryBot.create(:baseten_request) }

    context 'when the API request is successful' do
      before do
        stub_request(:post, "https://model-#{model_id}.api.baseten.co/development/async_predict")
          .to_return(status: 200, body: { request_id: 'sample_request_id' }.to_json)
      end

      it 'sets the request_id on the BasetenRequest object' do
        request.generate_avatar(baseten_api_key, model_id, prompt)
        expect(request.request_id).to eq('sample_request_id')
      end
    end

    context 'when the API request raises an exception' do
      before do
        allow(HTTParty).to receive(:post).and_raise(StandardError)
      end

      it 'raises the exception' do
        expect { request.generate_avatar(baseten_api_key, model_id, prompt) }.to raise_error(StandardError)
      end
    end
  end
end
