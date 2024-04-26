class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]


  # TasksController
  before_action :set_students, only: %i[ edit new ]

  authorize_resource

  # GET /tasks
  def index
    @tasks = Task.all
    @tasks = @tasks.where(student_id: current_user.id) if current_user.role == 'student'
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/1/edit
  def edit
  end

  # GET /tasks/new
  def new
    @students = User.where(role: :student)
    @task = params[:task_id] ? Task.find(params[:task_id]) : Task.new
    render 'teachers/add_new_task' # Make sure this matches the actual path to your template
  end


  def update
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
      redirect_to teachers_dashboard_path, notice: 'Tasks were successfully created.'
    else
      render 'teachers/add_new_task'
    end
  end



  # POST /tasks/search_students
  def search_students
    @students = User.where(role: 'student')
    @students = @students.where('full_name LIKE ?', "%#{params[:search_students][:full_name]}%") if params[:search_students][:full_name].present?
  end

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
      redirect_to teachers_dashboard_path, notice: 'Tasks were successfully created.'
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
    redirect_to teachers_dashboard_path, notice: 'Task was successfully deleted.'
  end

  # POST /tasks/search
  def search
    if current_user.role == 'student'
      @tasks = Task.where(student_id: current_user.id)
    else
      @tasks = Task.where(teacher_id: current_user.id)
    end

    # @tasks = @tasks.where(teacher_id: params[:search][:teacher_id]) if params[:search][:teacher_id].present?
    # @tasks = @tasks.where(student_id: params[:search][:student_id]) if params[:search][:student_id].present?
    # @tasks = @tasks.where(name: params[:search][:name]) if params[:search][:name].present?

    @tasks = @tasks.where(teacher_id: params[:search][:teacher_id]) if params[:search][:teacher_id].present?
    @tasks = @tasks.where('name LIKE ?', "%#{params[:search][:name]}%") if params[:search][:name].present?

    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @tasks = Task.find(params[:id])
    end

    def set_students
      @students =  User.where(role: :student)
    end

    # Only allow a list of trusted parameters through.
    def task_params
      # Ensure you permit student__id and not user_id if that's what the Task model expects
      params.require(:task).permit(:name, :teacher_id, :description, :deadline, :recording_boolean, :reward_xp, student_id: [])
    end
end
