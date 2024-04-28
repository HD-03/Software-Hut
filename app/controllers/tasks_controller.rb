class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy new ]
  before_action :set_role

  authorize_resource

  # GET /tasks
  def index
    @tasks = Task.all
    @tasks = @tasks.where(teacher_id: current_user.id) if @user_is_teacher
    @tasks = @tasks.where(student_id: current_user.id) if @user_is_student
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/1/edit
  def edit
  end

  # GET /tasks/new
  def new
    @students = params[:student_ids] ? User.find(params[:student_ids]) : User.where(role: :student)
  end


  # def update
  #   student_ids = params[:task].delete(:student_id).reject(&:empty?) # Remove empty elements

  # #   # Iterate over each student ID and create a new task
  # #   @tasks = student_ids.map do |student_id|
  # #     current_task = Task.new(task_params)
  # #     current_task.student_id = student_id
  # #     current_task.teacher_id = current_user.id
  # #     current_task.time_set = Time.current

  # #     # You can handle each save individually or collect errors
  # #     current_task.save
  # #     current_task
  # #   end

  #   if @tasks.all?(&:persisted?)
  #     redirect_to teachers_path, notice: 'Tasks were successfully created.'
  #   else
  #     render 'teachers/add_new_task'
  #   end
  # end



  # POST /tasks/search_students
  #
  # Searches for students based on the provided full name search term.
  # If a search term is present, it splits the term into individual words
  # and constructs a SQL condition to find students whose full name contains
  # all the words (case-insensitive).
  # Redirects to the new task page with the matching student IDs as query parameters.
  # def search_students
  #   if params[:search_students][:full_name].present?
  #     full_name_words = params[:search_students][:full_name].split
  #     conditions = full_name_words.map { |word| "full_name ILIKE '%#{word}%'" }

  #     @students = @students.where(conditions.join(" AND "))
  #   end

  #   authorize! :search_students, Task
  #   redirect_to new_task_path(student_ids: @students.map(&:id))
  # end

  # POST /tasks
  def create
    student_ids = params[:task].delete(:student_id).reject(&:empty?) # Remove empty elements

    # Iterate over each student ID and create a new task
    @tasks = student_ids.map do |student_id|
      current_task = Task.new(task_params)
      current_task.student_id = student_id
      current_task.teacher_id = current_user.id
      current_task.time_set = Time.current

      # You can handle each save individually or collect errors
      current_task.save
      current_task
    end

    if @tasks.all?(&:persisted?)
      redirect_to teachers_path, notice: 'Tasks were successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1
  # def update
  #   if @task.update(task_params)
  #     redirect_to teachers_dashboard_path, notice: "Task was successfully updated."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end


  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
<<<<<<< HEAD
    redirect_to teachers_dashboard_path, notice: 'Task was successfully deleted.'
=======
    redirect_to teachers_path, notice: "task was successfully destroyed.", status: :see_other
>>>>>>> origin/search-new-task-fix
  end

  # POST /tasks/search
  def search
    if @user_is_student
      @tasks = Task.where(student_id: current_user.id)
    elsif @user_is_teacher
      @tasks = Task.where(teacher_id: current_user.id)
    else
      @tasks = Task.all
    end

    if params[:search][:teacher_id].present? && params[:search][:student_id].present?
      @tasks = @tasks.where(teacher_id: params[:search][:teacher_id], student_id: params[:search][:student_id])
    elsif params[:search][:student_id].present?
      @tasks = @tasks.where(student_id: params[:search][:student_id])
    elsif params[:search][:teacher_id].present?
      @tasks = @tasks.where(teacher_id: params[:search][:teacher_id])
    end

    @tasks = @tasks.where('name LIKE ?', "%#{params[:search][:name]}%") if params[:search][:name].present?
    
    authorize! :search, Task
    render :index

    authorize! :search, Task
  end

  private

    def set_role
      @user_is_student = current_user.role == 'student'
      @user_is_teacher = current_user.role == 'teacher'
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = params[:task_id] ? Task.find(params[:task_id]) : Task.new
    end

    # Only allow a list of trusted parameters through.
    def task_params
      # Ensure you permit student__id and not user_id if that's what the Task model expects
      params.require(:task).permit(:name, :teacher_id, :description, :deadline, :recording_boolean, :reward_xp, student_id: [])
    end
end
