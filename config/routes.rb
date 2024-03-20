Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Example route for a teacher's dashboard. Adjust according to your actual controller and action names.
  get 'teachers/dashboard', to: 'teachers#dashboard', as: 'teachers_dashboard'

  # Example route for adding a new task. Adjust according to your actual controller and action names.
  get 'teachers/add_new_task', to: 'teachers#add_new_task', as: 'new_add_task'

  # Defines the root path route ("/")
  root "pages#home"
end
