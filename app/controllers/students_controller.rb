class StudentsController < ApplicationController
  load_and_authorize_resource class: "User"

  # GET /students
  def index
    @tasks = Task.where(student_id: current_user.id)
    
    authorize! :index, :students
  end
end
