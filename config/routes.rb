Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'teachers/dashboard', to: 'teachers#dashboard', as: 'teachers_dashboard'
  get 'students/dashboard', to: 'students#dashboard', as: 'students_dashboard'

  resources :tasks do
    post :search, on: :collection
  end

  get 'tasks/add_new_task', to: 'tasks#add_new_task', as: 'add_new_task'

  # Defines the root path route ("/")
  root "pages#home"
end
