require 'rails_helper'

RSpec.feature 'Tasks management', type: :feature, js: true do
  let(:teacher) { FactoryBot.create(:user, role: :teacher) }
  let(:student) { FactoryBot.create(:user, role: :student, full_name: 'student 1 test') }
  let!(:task1) { FactoryBot.create(:task, teacher: teacher, student: student, description: "Unique sample description1", reward_xp: 100) }


  before do
    login_as(teacher, scope: :user)
  end

  scenario 'Teacher adds a new task', js: true do
      visit new_task_path
      fill_in 'Task Name', with: 'New Task'
      fill_in 'Task Description', with: 'Task description from making a new task'

      # Activate the Select2 dropdown
      # Simulate the user interaction with select2 dropdown
      find('.select2-selection--multiple').click
      # You may need to adjust the selector based on your specific implementation of select2
      find('.select2-results__options').find('.select2-results__option', text: student.full_name).click




      fill_in 'Experience Points', with: 50
      # Interact with the date picker if it's a special widget, otherwise just fill it in:
      fill_in 'Deadline', with: '2024-12-31'
      select 'Yes', from: 'Allow Recording?'


      click_button 'Submit'
      expect(page).to have_content('Task description from making a new task')


      # More expectations for other fields
    end

  scenario 'Teacher deletes a task' do
    visit teachers_path
    expect(page).to have_content("student 1 test")

    within("##{student.username}") do
      find(".accordion-button").click  # Simulate clicking the accordion to show task details
      expect(page).to have_content("Unique sample description1")

      page.execute_script('window.confirm = function() { return true; }')

      click_link 'Delete'
      page.execute_script('window.confirm = function(message) { return confirm(message); }')

  end

  end
end


describe 'Use Template.' do

  let!(:teacher_test1) { FactoryBot.create(:user, email: 'teacher_test1@test.com', role: 1) }
  let!(:student_test1) { FactoryBot.create(:user, email: 'student_test1@test.com', full_name: 'teststudentfullname 1', role: 0) }
  let!(:student_test2) { FactoryBot.create(:user, email: 'student_test2@test.com', full_name: 'teststudentfullname 2', role: 0) }

  let!(:task1) { FactoryBot.create(:task, teacher: teacher_test1, student: student_test1, description: "Unique sample description1", reward_xp: 100) }



  before do
    login_as teacher_test1
    visit 'teachers'
  end

  it 'loads the teacher dashboard' do
    expect(page).to have_content('My Students')
    expect(page).to have_content('Use as template')
    expect(page).to have_content(task1.name)
    within("##{student_test1.username}") do
      expect(page).to have_content(student_test1.full_name)
      expect(page).to have_link('Use as template')
    end
  end



  it 'allows the teacher to use a task as a template' do
    # Navigate to the student section and expand it
    within("##{student_test1.username}") do
      find(".accordion-button").click  # Simulate clicking the accordion to show task details
      click_link 'Use as template', href: new_task_path(task_id: task1.id)
    end
    expect(current_path).to eq(new_task_path)
    expect(page).to have_content("Set task")
  end

  it 'verifies that the task details are auto-filled correctly and can submit a new task' do
    visit new_task_path(task_id: task1.id)

    # Check for pre-filled fields
    expect(find_field('Task Name').value).to eq task1.name
    expect(find_field('Task Description').value).to eq task1.description
    expect(find_field('Experience Points').value).to eq task1.reward_xp.to_s

    # Fill in additional fields and submit
    fill_in 'Task Description', with: 'Updated description from template'
    fill_in 'Deadline', with: 3.days.from_now.to_date  # Add a deadline


    click_button 'Submit'

    # After submission, verify the task details are correct on the task show page or similar
    expect(page).to have_content('Updated description from template')

    # Further check if the task count has increased
  end




end
