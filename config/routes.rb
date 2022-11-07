Rails.application.routes.draw do
  devise_for :users
  root 'home#homepage'
  get 'homepage', to: 'home#homepage'
  get 'public_page', to: 'home#public_page'
  resources :purchases do
    collection do
      get 'remove_all'
    end
  end
end
