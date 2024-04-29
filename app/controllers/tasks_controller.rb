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
    @instruments = Instrument.all
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
      redirect_to teachers_path, notice: 'Tasks were successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to teachers_path, notice: 'Task was successfully deleted.'
  end

  # POST /tasks/search
  def search
    # Initial sort of tasks based on the user
    if @user_is_student
      @tasks = Task.where(student_id: current_user.id)
    elsif @user_is_teacher
      @tasks = Task.where(teacher_id: current_user.id)
    else
      @tasks = Task.all
    end

    # Search by intrument
    if params[:search][:instrument_id].present?
      @tasks = @tasks.where(instrument_id: params[:search][:instrument_id])
    end
      
    # Search by student or/and teacher
    if params[:search][:teacher_id].present? && params[:search][:student_id].present?
      @tasks = @tasks.where(teacher_id: params[:search][:teacher_id], student_id: params[:search][:student_id])
    elsif params[:search][:student_id].present?
      @tasks = @tasks.where(student_id: params[:search][:student_id])
    elsif params[:search][:teacher_id].present?
      @tasks = @tasks.where(teacher_id: params[:search][:teacher_id])
    end

    # Search by name
    @tasks = @tasks.where('name LIKE ?', "%#{params[:search][:name]}%") if params[:search][:name].present?
    
    authorize! :search, Task
    render :index
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
      params.require(:task).permit(:name, :instrument_id, :teacher_id, :description, :deadline, :recording_boolean, :reward_xp, student_id: [])
    end
end
