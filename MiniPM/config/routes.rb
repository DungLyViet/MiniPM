Rails.application.routes.draw do
	resources :users, only: [:new, :create, :destroy]
	resources :sessions, only: [:new, :create, :destroy]
	resources :projects, only: [:new, :create, :destroy]

	root 'welcome#index'

	get '/signup', to: 'users#new'

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

	get 'welcome/index'

	get 'users/signed_up_success'
end
