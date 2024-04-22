Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Example route for a teacher's dashboard. Adjust according to your actual controller and action names.
  get 'teachers/dashboard', to: 'teachers#dashboard', as: 'teachers_dashboard'

  # Example route for adding a new task. Adjust according to your actual controller and action names.
  get 'teachers/add_new_task', to: 'teachers#add_new_task', as: 'new_add_task'

  get 'students/dashboard', to: 'students#dashboard', as: 'students_dashboard'

  # -------------------------------------------------------------------
  #       check merge issues here !!!!!!!!!!!!!!!!!!!!!!!!!!
  post 'teachers/tasks', to: 'tasks#create', as: 'create_task'

  resources :tasks do
    post :search, on: :collection
  end
  # -------------------------------------------------------------------

  # route for viewing the admin dashboard
  get 'admin/dashboard', to: 'admin#dashboard', as: 'admin_dashboard'

  # get route for adding a new user.
  get 'admin/add_new_user', to: 'admin#add_new_user', as: 'new_add_user'

  # post route to submit the new user form

  #  get route for editing user details
  get 'admin/edit_user_info', to: 'admin#edit_user_info', as: 'edit_user'

  # route to submit the edit user form

  # Defines the root path route ("/")
  root "pages#home"
end
