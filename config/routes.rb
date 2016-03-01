Rails.application.routes.draw do

root to: 'pages#front'

post '/sign_in', to: 'sessions#create'
get '/sign_out', to: 'sessions#destroy'

end
