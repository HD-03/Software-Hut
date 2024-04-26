class TeachersController < ApplicationController

  # GET /teachers
  def index
    @students = User.joins(:tasks).where(role: :student, tasks: { teacher_id: current_user.id}).distinct  # Assuming you have a role attribute
    @tasks = Task.where(teacher_id: current_user.id)

    authorize! :index, :teachers
  end
end



