Rails.application.routes.draw do
  root 'pages#home'
  
  resources :categories do
    member do
      patch :move
    end
  end
  resources :items do
    member do
      patch :move
    end
  end
end
