require 'rails_helper'

RSpec.describe Webhooks::BasetenController, type: :controller do
  describe 'POST #create' do
    let(:payload) { '{"key": "value"}' }

    before do
      allow(Webhooks::BasetenJob).to receive(:perform_later)
    end

    it 'enqueues the Webhooks::BasetenJob with the payload' do
      post :create, body: payload

      expect(Webhooks::BasetenJob).to have_received(:perform_later).with(payload)
    end

    it 'returns a 200 OK response' do
      post :create, body: payload

      expect(response).to have_http_status(:ok)
    end
  end
end