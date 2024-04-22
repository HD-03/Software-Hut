class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_students, only: %i[ edit new ]

  authorize_resource

  # GET /tasks
  def index
    @tasks = Task.all
    @tasks = @tasks.where(student_id: current_user.id) if current_user.role == 'student'

    authorize! :read, @tasks
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/1/edit
  def edit
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.teacher_id = current_user.id
    @task.time_set = Time.current # or another appropriate time value


    if @task.save
      redirect_to teachers_dashboard_path, notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to teachers_dashboard_path, notice: "Task was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to teachers_dashboard_path, notice: "task was successfully destroyed.", status: :see_other
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
      @students = User.where(role: :student)
    end

    # Only allow a list of trusted parameters through.
    def task_params
      # Ensure you permit student__id and not user_id if that's what the Task model expects
      params.require(:task).permit(:name, :student_id, :teacher_id, :description, :deadline, :recording_boolean,:reward_xp)
    end
end
