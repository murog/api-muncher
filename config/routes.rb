Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'application#index'
get 'search/:id', to: "recipes#pages", as: "pages"
post 'search', to: 'recipes#search', as: 'search'
get '/results', to: 'recipes#results', as: 'results'
get 'recipes/:id', to: 'recipes#show', as: 'show_recipe'
get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"

end
