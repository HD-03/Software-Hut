class StudentsController < ApplicationController

  # GET /students
  def index
    @tasks = Task.where(student_id: current_user.id)
    
    authorize! :index, :students
  end
end
