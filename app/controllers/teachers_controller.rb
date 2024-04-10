class TeachersController < ApplicationController
  def add_new_task
  end

  def dashboard
    @students = Student.all # Suggestion: `@students = User.where(role: :student)`
  end  
end
