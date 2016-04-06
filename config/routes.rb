Rails.application.routes.draw do

root to: 'pages#front'

get '/sign_in', to: 'sessions#new'
post '/sign_in', to: 'sessions#create'
post '/sign_in_with_presspass', to: 'sessions#create_with_presspass'
get '/sign_out', to: 'sessions#destroy'
get '/purchase', to: 'purchases#new'
post '/purchase', to: 'purchases#create'
post '/purchase_with_presspass', to: 'purchases#purchase_with_presspass'


namespace :presspass do
  post 'sign_in', to: 'presspass#sign_in'
  post 'register', to: 'users#create'
  post 'create_token', to: 'presspass#create_token'
  get 'get_token', to: 'presspass#get_token'
  get 'get_purchase_token', to: 'presspass#get_purchase_token'
  post 'purchase', to: 'presspass#purchase'
  post 'create_purchase_token', to: 'presspass#create_purchase_token'
end
  


end
