Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #for user settings
  resources :users, only: [:show, :edit], path_names: { update: 'settings' }


  # Defines the root path route ("/")
  root "pages#home"

  # Dashboards
  get 'teachers/dashboard', to: 'teachers#dashboard', as: 'teachers_dashboard'
  get 'students/dashboard', to: 'students#dashboard', as: 'students_dashboard'
  get 'admin/dashboard', to: 'admin#dashboard', as: 'admin_dashboard'

  # -------------------------------------------------------------------
  #       check merge issues here !!!!!!!!!!!!!!!!!!!!!!!!!!
  # get route for adding a new user.
  get 'admin/add_new_user', to: 'admin#add_new_user', as: 'new_add_user'

  # post route to submit the new user form
  post 'admin/add_new_user', to: 'admin#create', as: 'create_new_user'
  
  #  get route for editing user details
  get 'admin/edit_user/:id', to: 'admin#edit_user_info', as: 'edit_user_admin'

  # route to submit the edit user form
  patch 'admin/update_user/:id', to: 'admin#update_user', as:'update_user'

  delete 'admin/delete_user/:id', to: 'admin#delete_user', as: 'delete_user'

  post 'teachers/tasks', to: 'tasks#create', as: 'create_task'

  resources :tasks do
    post :search, on: :collection
  end

  resources :users do
    post :search, on: :collection
  end

  # -------------------------------------------------------------------
end
