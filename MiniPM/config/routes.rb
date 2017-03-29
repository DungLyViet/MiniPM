Rails.application.routes.draw do
	resources :users, only: [:new, :create, :destroy]
	resources :sessions, only: [:new, :create, :destroy]
	resources :projects, only: [:new, :create, :destroy]
	resources :tasks, only: [:new, :create, :destroy]
	resources :pus, only: [:new, :create, :destroy]

	root 'welcome#index'

	get '/signup', to: 'users#new'
	post '/edituser', to: 'users#edit'
	put '/users/:id', to: 'users#update'

	get '/about', to: 'utility#about'
	get '/author', to: 'utility#author'
	get '/error', to: 'utility#error'

	get '/signin', to: 'sessions#new'
	get '/signout', to: 'sessions#destroy', via: :delete
	get '/signedin', to: 'sessions#user'
	get '/profile', to: 'sessions#profile'
	get '/listprojects', to: 'sessions#listProjects'

	get '/createproject', to: 'projects#new'
	get '/deleteproject', to: 'projects#destroy', via: :delete
	put '/projects/:id', to: 'projects#update'
	post '/editproject', to: 'projects#edit'
	post '/projectoperations', to: 'projects#operations'
	get '/allusers', to: 'projects#allUsers'
	get '/alltasks', to: 'projects#allTasks'
	get '/owntasks', to: 'projects#ownTasks'

	get '/createtask', to: 'tasks#new'
	get '/deletetask', to: 'tasks#destroy', via: :delete
	put '/tasks/:id', to: 'tasks#update'
	post '/edittask', to: 'tasks#edit'

	get '/addusertoproject', to: 'pus#new'
	get '/deleteuserproject', to: 'pus#destroy', via: :delete

	get 'welcome/index'

	get 'users/signed_up_success'
end
