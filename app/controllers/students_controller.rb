class StudentsController < ApplicationController
  # GET /students
  def dashboard
    @tasks = Task.where(student_id: current_user.id)
  end

  # POST /students/search
  def search
    @students = User.where(role: 'student')
    @students = @students.where('full_name LIKE ?', "%#{params[:search][:full_name]}%") if params[:search][:full_name].present?

    # @students.each do |s|
    #   puts s.full_name
    # end
    session[:student_ids] = @students.map(&:id)

    redirect_to new_task_path
  end
end
