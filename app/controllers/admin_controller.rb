class AdminController < ApplicationController
    # before_action :authenticate_admin

    # GET /dashboard
    def dashboard
        @students = Student.all
        @teachers = Teacher.all
    end
    
    # POST create new users
    def create
    end

    # delete users
    def remove
    end

    #edit users
    def edit
    end

    def user_params
        params.require()
    end
end
