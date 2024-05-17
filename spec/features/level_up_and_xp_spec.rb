require 'rails_helper'

describe 'level_up_and_xp.' do
  let!(:student) { FactoryBot.create(:user) }
  let!(:teacher) { FactoryBot.create(:user, email: 'teacher_test@test.com',role: 1) }
  let!(:task) { FactoryBot.create(:task, student: student, teacher: teacher) }
  #let!(:task) { FactoryBot.create(:task) }
  #before { login_as student }

  specify "I don't see a pop up in my student dashboard when I haven't leveled up" do
    student.recently_leveled_up = false
    login_as student
    visit '/students'
    
    expect(page).to have_selector('#levelUpModal', visible: false)
  end

  specify 'I see a pop up in my student dashboard when I level up' do
    student.recently_leveled_up = true
    login_as student
    visit '/students'

    expect(page).to have_selector('#levelUpModal', visible: :visible)
  end

  specify 'The pop up modal has the correct content (including my new level)' do
    student.recently_leveled_up = true
    login_as student
    visit '/students'

    within('#levelUpModal') do
      expect(page).to have_content("Level #{student.level} reached")
      expect(page).to have_content("You have unlocked a generate token!")
    end
  end


  context 'testing give student xp from teacher dashboard' do

    specify 'If I try to give a student xp points less than 1 I will get an error alert', js: true do
      login_as teacher
      visit '/teachers'

      find("##{student.username}").click
      fill_in "xpPointsInput-#{student.id}", with: 0
      #click_on 'Give Student XP'

      alert_text = accept_alert do
        click_on 'Give Student XP'
      end
    
      expect(alert_text).to eq('Error in giving XP points: number of xp points given cannot be less than 1')
    end

    specify 'If I try to give a student xp points more than 100 I will get an error alert', js: true do
      login_as teacher
      visit '/teachers'

      find("##{student.username}").click
      fill_in "xpPointsInput-#{student.id}", with: 101

      alert_text = accept_alert do
        click_on 'Give Student XP'
      end
    
      expect(alert_text).to eq('Error in giving XP points: number of xp points given cannot be more than 100')
    end

    specify 'If i give student xp points (1 to 100) I will get a success alert', js: true do
      login_as teacher
      visit '/teachers'
      # 1 ----------------------- 
      xp_points = 50

      find("##{student.username}").click
      fill_in "xpPointsInput-#{student.id}", with: xp_points

      alert_text = accept_alert do
        click_on 'Give Student XP'
      end
    
      expect(alert_text).to eq("#{xp_points} XP points given to #{student.full_name}")

      # 2 -----------------------
      xp_points2 = 100

      fill_in "xpPointsInput-#{student.id}", with: xp_points2

      alert_text = accept_alert do
        click_on 'Give Student XP'
      end
    
      expect(alert_text).to eq("#{xp_points2} XP points given to #{student.full_name}")
      
      # 3 -----------------------
      xp_points3 = 1

      fill_in "xpPointsInput-#{student.id}", with: xp_points3

      alert_text = accept_alert do
        click_on 'Give Student XP'
      end
    
      expect(alert_text).to eq("#{xp_points3} XP points given to #{student.full_name}")
    end

    specify 'If I try give a student xp points outside of range it will not give the student xp', js: true do
      student.xp_points = 10
      login_as teacher
      visit '/teachers'

      find("##{student.username}").click
      fill_in "xpPointsInput-#{student.id}", with: 101
      click_on 'Give Student XP'
    
      expect(student.xp_points).to eq(10)
    end

    # specify 'If i give student xp points in range the students xp points and level will increase accordingly', js: true do
    #   student.xp_points = 10
    #   login_as teacher
    #   visit '/teachers'

    #   find("##{student.username}").click
    #   fill_in "xpPointsInput-#{student.id}", with: 60
    #   puts (student.xp_points)
      
    #   accept_alert do
    #     click_on 'Give Student XP'
    #   end
      
    #   expect(student.xp_points).to eq(70)
    # end
    
  end

end