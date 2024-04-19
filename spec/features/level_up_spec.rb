require 'rails_helper'

describe 'level_up.' do
  let!(:student) { FactoryBot.create(:user) }

  visit '/'
  click_on 'Log in'
  fill_in 'Email', with: 'student_test@test.com'
  fill_in 'Password', with: 'Password1234'
  within(:css, 'form') { click_on 'Log in' }

  specify 'I see a pop up when I level up' do
    skip
  end
end