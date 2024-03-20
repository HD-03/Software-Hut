class TeachersController < ApplicationController
  def add_new_task
  end
  def dashboard
    @students = Student.all
  end
  
end
