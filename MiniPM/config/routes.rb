Rails.application.routes.draw do
  get 'utility/about'

	resources :users

	root 'welcome#index'

	get '/signup', to: 'users#new'
	get '/about', to: 'utility#about'
	get '/author', to: 'utility#author'

	get 'welcome/index'

	get 'users/signed_up_success'
end
