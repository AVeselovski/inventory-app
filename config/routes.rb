Rails.application.routes.draw do
  root 'pages#home'
  
  resources :items
  resources :categories
end
