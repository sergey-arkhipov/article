Rails.application.routes.draw do
  resources :texts
  # get 'text/:id', to: 'texts#edit', as: 'text_edit'
  get 'articles/:id/:version', to: 'articles#show', as: 'articles_text'
  get 'article/:id/edit/:version', to: 'articles#edit', as: 'articles_text_edit'
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'articles#index'
end
