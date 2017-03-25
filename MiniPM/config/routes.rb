Rails.application.routes.draw do
	resources :users
	resources :sessions, only: [:new, :create, :destroy]

	root 'welcome#index'

	get '/signup', to: 'users#new'
	get '/about', to: 'utility#about'
	get '/author', to: 'utility#author'
	get '/error', to: 'utility#error'

	get '/signin', to: 'sessions#new'
	get '/signout', to: 'sessions#destroy', via: :delete
	get '/signedin', to: 'sessions#user'
	get '/profile', to: "sessions#profile"

	get 'welcome/index'

	get 'users/signed_up_success'
end
