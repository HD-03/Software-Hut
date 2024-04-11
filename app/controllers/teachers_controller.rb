class TeachersController < ApplicationController
  def add_new_task
  end

  def dashboard
    @students = User.where(role: :student)
  end  
end
