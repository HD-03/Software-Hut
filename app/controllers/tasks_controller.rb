class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # POST /tasks/search
  def search
    @tasks = Task.all
    @tasks = @tasks.where(teacher_id: params[:search][:teacher_id]) if params[:search][:teacher_id].present?
    @tasks = @tasks.where(student_id: params[:search][:student_id]) if params[:search][:student_id].present?
    @tasks = @tasks.where(name: params[:search][:name]) if params[:search][:name].present?
      
    render :tasks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @tasks = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tasks_params
      params.require(:task).permit(:name, :teacher_id, :student_id)
    end
end