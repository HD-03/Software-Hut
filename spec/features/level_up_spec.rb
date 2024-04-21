require 'rails_helper'

describe 'level_up.' do
  let!(:student) { FactoryBot.create(:user) }
  before { login_as student }

  specify 'I see a pop up when I level up' do
    skip
  end
end