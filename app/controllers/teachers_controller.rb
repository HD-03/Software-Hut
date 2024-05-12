class TeachersController < ApplicationController

  # GET /teachers
  def index
    @students = User.joins(:tasks).where(role: :student, tasks: { teacher_id: current_user.id}).distinct
    @tasks = Task.where(teacher_id: current_user.id)

    authorize! :index, :teachers
  end

  def give_student_xp
    student = User.find(params[:xp_points_form][:student_id])
    xp_points = params[:xp_points_form][:number_of_xp_points].to_i

    if xp_points > 0 && xp_points < 100
      User.give_student_xp_points(student, xp_points)
      student.save
    end

    respond_to do |format|
      if xp_points > 0 && xp_points <= 100
        format.js { render js: "alert('#{xp_points} XP points given to #{student.full_name}');" }
      elsif xp_points <= 0
        format.js { render js: "alert('Error in giving XP points: number of xp points given cannot be less than 1');" }
      elsif xp_points > 100
        format.js { render js: "alert('Error in giving XP points: number of xp points given cannot be more than 100');" }
      else
        format.js { render js: "alert('Error in giving XP points: unknown error');" }
      end
    end

  end

end



