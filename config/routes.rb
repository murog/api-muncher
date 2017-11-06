Rails.application.routes.draw do
resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'application#index'
get 'favorites', to: "users#favorites", as: "favorites"
get 'search/:id', to: "recipes#pages", as: "pages"
get '/results', to: 'recipes#results', as: 'results'
get 'recipes/:id', to: 'recipes#show', as: 'show_recipe'
post 'recipes/:id', to: 'recipes#add_to_favorites', as: 'add_to_favorites'
delete 'recipes/:id', to: 'recipes#remove_from_favorites', as: 'remove_from_favorites'
get 'logout', to: 'sessions#logout', as: 'logout'
get "/auth/google_oauth2", to: "sessions#create", as: "google_login"
get "/auth/google_oauth2/callback", to: "sessions#create", as: "auth_callback"


end
