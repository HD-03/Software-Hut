class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.new(task_params)
    @task.teacher_user_id = current_user.id
    @task.time_set = Time.current # or another appropriate time value


    if @task.save
      redirect_to teachers_dashboard_path, notice: 'Task was successfully created.'
    else
      render 'teachers/add_new_task'
    end
  end

  private

  def task_params
    # Ensure you permit student_user_id and not user_id if that's what the Task model expects
    params.require(:task).permit(:name, :student_user_id, :description, :deadline, :recording_boolean,:base_experience_points)
  end
end
