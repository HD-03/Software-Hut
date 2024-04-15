class AdminController < ApplicationController
    #dashboard
    def dashboard
        @users = User.all
    end
    
    # create new users
    def create
    end

    # delete users
    def remove
    end

    #edit users
    def edit
    end
end
