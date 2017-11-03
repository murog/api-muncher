Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'application#index'
post 'search', to: 'recipes#search', as: 'search'
get '/results', to: 'recipes#results', as: 'results'

end
