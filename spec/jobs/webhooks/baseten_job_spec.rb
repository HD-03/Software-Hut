require 'rails_helper'

RSpec.describe Webhooks::BasetenJob, type: :job do
  describe '#perform' do
    let(:student) { create(:user) }
    let(:baseten_request) { create(:baseten_request, student: student) }
    let(:temp_avatar_path) { Rails.root.join('spec/jobs/webhooks', 'temp_avatar.png') }

    let(:payload) do
      {
        request_id: baseten_request.request_id,
        data: {
          result: [
            {
              data: Base64.encode64(File.read(temp_avatar_path))
            }
          ]
        }
      }.to_json
    end

    it 'saves the decoded image as a new avatar attachment for the student' do
      expect {
        subject.perform(payload)
      }.to change { student.reload.avatar.count }.by(1)
    end

    it 'decrements the student generate_tokens' do
      expect {
        subject.perform(payload)
      }.to change { student.reload.generate_tokens }.by(-1)
    end
  end
end
