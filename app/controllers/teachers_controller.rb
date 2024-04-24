class TeachersController < ApplicationController
  before_action :authenticate_user!, only: [:add_new_task, :dashboard]
  before_action :set_students, only: [:dashboard, :add_new_task]


  before_action :authenticate_user!

  def dashboard
    @students = User.joins(:tasks).where(role: :student, tasks: { teacher_id: current_user.id}).distinct  # Assuming you have a role attribute
    @tasks = Task.where(teacher_id: current_user.id)
  end
  
  def set_students
    @students = User.where(role: :student)
  end
end



