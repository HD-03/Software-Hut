class TeachersController < ApplicationController
  before_action :authenticate_user!, only: [:add_new_task, :dashboard]
  before_action :set_students, only: [:dashboard, :add_new_task]

  def add_new_task
    @task = Task.new  # Ensure @task is not nil
  end

  def dashboard
    @students = User.where(role: :student)  # Assuming you have a role attribute
    @tasks = Task.all
  end

  private

  def set_students
    @students = User.where(role: :student)
  end
end


