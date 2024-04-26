class StudentsController < ApplicationController

  # GET /students
  def dashboard
    @tasks = Task.where(student_id: current_user.id)
  end
end
