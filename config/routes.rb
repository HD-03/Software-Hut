Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'teachers/dashboard', to: 'teachers#dashboard', as: 'teachers_dashboard'
  get 'students/dashboard', to: 'students#dashboard', as: 'students_dashboard'

  # Routes for tasks. This sets up the standard RESTful actions.
  resources :tasks do
    # Custom route for searching tasks
    post :search, on: :collection
    # You could also add a new member or collection route here if you need one
  end

  # Custom route for adding a new task or using a task as a template
  # Remove the 'as: new_task' if you are not using it to resolve the conflict
  get 'tasks/add_new_task', to: 'tasks#add_new_task', as: 'add_new_task' # or another path as you've defined it

  

  # This route seems to duplicate the 'create' action already provided by 'resources :tasks'
  # If you need a custom path for the create action, ensure it has a unique name.
  # post 'teachers/tasks', to: 'tasks#create'

  # Defines the root path route ("/")
  root "pages#home"
end
