Rails.application.routes.draw do
  get 'articles/:id/:version', to: 'articles#show', as: 'articles_text'
  post 'articles/:id/:version', to: 'articles#show', as: 'articles_text_version'
  get 'article/:id/edit/:version', to: 'articles#edit', as: 'articles_text_edit'
  resources :articles, except: :update
  resources :texts, only: %i[edit update destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'articles#index'
end
