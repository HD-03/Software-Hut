class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :set_user, only: [:edit, :update, :destroy]
  
    def dashboard
      @students = User.where(role: :student)
      @teachers = User.where(role: :teacher)
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      set_default_student_attributes if @user.student?
  
      if @user.save
        redirect_to admin_dashboard_path, notice: 'User was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        redirect_to admin_dashboard_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to admin_dashboard_path, notice: 'User was successfully deleted.'
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:full_name, :email, :username, :password, :role, :old_enough_for_cooler_avatars)
    end
  
    def check_admin
      redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
    end
  
    def set_default_student_attributes
      @user.level = 1
      @user.xp_points = 0
      @user.avatar_id = 1
      @user.old_enough_for_cooler_avatars = params[:user][:old_enough_for_cooler_avatars] if params[:user][:old_enough_for_cooler_avatars]
    end
  end  