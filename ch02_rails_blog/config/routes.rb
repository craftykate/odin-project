Rails.application.routes.draw do
  resources :articles do 
  	resources :comments
  end
  resources :tags
  root to: 'articles#index'
end
