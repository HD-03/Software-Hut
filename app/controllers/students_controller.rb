class StudentsController < ApplicationController

  # GET /students
  def index
    check_level_up
    @tasks = Task.where(student_id: current_user.id)
    
    authorize! :index, :students
  end

  def give_student_xp
    User.give_student_xp_points(current_user, 600)

    authorize! :give_student_xp, :students
  end

  def show
    @task = Task.find(params[:id])
  end

  def check_level_up
    # Logic to determine if the student recently leveled up
    # Set @show_level_up_modal to true if the condition is met
    @show_level_up_modal = current_user.recently_leveled_up?
  end

end
