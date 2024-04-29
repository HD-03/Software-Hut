  class AdminController < ApplicationController
    before_action :authenticate_user!, only: [:dashboard, :add_new_user, :edit_user, :delete_user]
    before_action :set_user, only: [:edit_user_info, :update_user, :delete_user]

    # GET /dashboard
    def dashboard
        @students = User.where(role: :student)
        @teachers = User.where(role: :teacher)
    end

    def add_new_user
      @user = User.new
    end
    
    # POST create new users
    def create
        @user = User.new(user_params)
        # For students there are additional fields need such as lvl and xp_points and these would be default 
       set_default_student_attributes if @user.student?

        if @user.save
            redirect_to admin_dashboard_path, notice: 'User was successfully created'
        else
            render :add_new_user, status: :unprocessable_entity
        end
    end

    # delete users
    def delete_user
        @user.destroy
        redirect_to admin_dashboard_path, notice:'User was successfully deleted.'
    end

    # GET /users/1
    def show
    end


    # GET /user/1/edit
    def edit_user_info
    end

    #PATCH
    def update_user
        if @user.update(user_params)
            redirect_to admin_dashboard_path, notice: 'User was successfully updated.'
        else
            render :edit_user_info
        end
    end

    def search
    end

    def set_default_student_attributes
      @user.level = 1
      @user.xp_points = 0
      @user.avatar_id = 1
      @user.old_enough_for_cooler_avatars = params[:user][:old_enough_for_cooler_avatars] if params[:user][:old_enough_for_cooler_avatars]
    end

    private

        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.require(:user).permit(:full_name, :email, :username, :password, :role, :old_enough_for_cooler_avatars)
        end


end
