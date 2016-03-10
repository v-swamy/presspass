Rails.application.routes.draw do

root to: 'pages#front'

get '/sign_in', to: 'sessions#new'
post '/sign_in', to: 'sessions#create'
get '/sign_out', to: 'sessions#destroy'

resources :users

namespace :presspass do
  post 'sign_in', to: 'presspass#sign_in'
end
  


end
