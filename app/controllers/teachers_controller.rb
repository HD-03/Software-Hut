class TeachersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @students = User.joins(:tasks).where(role: :student, tasks: { teacher_id: current_user.id}).distinct  # Assuming you have a role attribute
    @tasks = Task.where(teacher_id: current_user.id)
  end
end


