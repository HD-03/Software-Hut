class StudentsController < ApplicationController

  # GET /students
  def index
    check_level_up
    @tasks = Task.where(student_id: current_user.id)
    
    authorize! :index, :students
  end

  #GET /students/avatars
  def avatars
  end

  # def give_student_xp
  #   User.give_student_xp_points(current_user, 600)
  # end

  # def show
  #   @task = Task.find(params[:id])
  # end

  def check_level_up
    # Logic to determine if the student recently leveled up
    # Set @show_level_up_modal to true if the condition is met
    @show_level_up_modal = current_user.recently_leveled_up?
  end

  def update_avatar_id
    current_user.avatar_id = params[:avatar_id]
    current_user.save
  end

  private
  def student_params
    params.permit(:avatar_id)
  end

end
