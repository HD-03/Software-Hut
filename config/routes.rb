Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  # ------------- Admin -------------
  get 'admin/dashboard', to: 'admin#dashboard', as: 'admin_dashboard'

  # get route for adding a new user.
  get 'admin/add_new_user', to: 'admin#add_new_user', as: 'new_add_user'

  # post route to submit the new user form
  post 'admin/add_new_user', to: 'admin#create', as: 'create_new_user'
  
  #  get route for editing user details
  get 'admin/edit_user/:id', to: 'admin#edit_user_info', as: 'edit_user_admin'

  # route to submit the edit user form
  patch 'admin/update_user/:id', to: 'admin#update_user', as:'update_user'

  delete 'admin/delete_user/:id', to: 'admin#delete_user', as: 'delete_user'
  # ---------------------------------


  #post 'teachers/tasks', to: 'tasks#create', as: 'create_task'
  # Example route for a teacher's dashboard. Adjust according to your actual controller and action names.
  # get 'teachers/dashboard', to: 'teachers#dashboard', as: 'teachers_dashboard'

  # Example route for adding a new task. Adjust according to your actual controller and action names.
  #get 'teachers/add_new_task', to: 'teachers#add_new_task', as: 'new_add_task'

  # get 'students/dashboard', to: 'students#dashboard', as: 'students_dashboard'

  resources :students do
    # for testing level up modal (delete after development for this is finished)
    post :give_student_xp
  end

  resources :teachers do
    post :give_student_xp
  end

  resources :tasks do
    post :search, on: :collection
  end

  resources :users, only: [:show, :edit], path_names: { update: 'settings' } do
    post :search, on: :collection
  end

  resources :tasks do
    member do
      patch 'update_status'
    end
  end

  authenticate :user do
    # Specific task show route - this is included in the resources :tasks above, so it's redundant here unless you need to restrict it to authenticated users only
    get 'tasks/:id', to: 'tasks#show', as: 'task_details'
  end
end
