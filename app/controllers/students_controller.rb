class StudentsController < ApplicationController
  # GET /students
  def dashboard
    check_level_up
    @tasks = Task.where(student_id: current_user.id)
  end

  def give_student_xp
    current_user.give_student_xp_points(600)
  end

  def check_level_up
    # Logic to determine if the student recently leveled up
    # Set @show_level_up_modal to true if the condition is met
    @show_level_up_modal = current_user.recently_leveled_up?
  end

  # if current_user.recently_leveled_up
  #   puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA RUNNING MODAL"

  #   :javascript
  #     $('#levelUpModal').modal('show');
  #   end

  #   current_user.update(recently_leveled_up: false)
  # end

  # def display_level_up_modal
  #   if current_user.recently_leveled_up == true
  #     puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA RUNNING MODAL"
  #     respond_to do |format|
  #       format.js { render partial: 'students/level_up_modal' }
  #     end

  #     current_user.update(recently_leveled_up: false)
  #     puts "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
  #   end
  # end

end
