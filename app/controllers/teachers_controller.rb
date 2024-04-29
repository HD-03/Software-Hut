class TeachersController < ApplicationController

  # GET /teachers
  def index
    @students = User.joins(:tasks).where(role: :student, tasks: { teacher_id: current_user.id}).distinct
    @tasks = Task.where(teacher_id: current_user.id)

    authorize! :index, :teachers
  end
end



