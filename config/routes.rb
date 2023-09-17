Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"

  # get '/artists', to: 'artists#index'
  # post '/signup', to: 'artists#create'
  # post '/login', to: 'artists#login'
  # put '/update', to: 'artists#update'
  # delete '/delete', to: 'artists#destroy'
  
  # # For SongsController
  # post '/add_song', to: 'songs#create'
  # put '/update_song/:id', to: 'songs#update'
  # delete '/delete_song/:id', to: 'songs#destroy'
  
  # # For AlbumsController
  # post '/create_album', to: 'albums#create'
  # put '/update_album/:id', to: 'albums#update'
  
  resources :users, only: [:index, :create]

  # Custom route for login
  post 'users/login', to: 'users#login'
  resources :songs
  resources :albums

  # resources :artists do
  #   get 'my_songs_and_albums', on: :collection
  # end

  resources :artists do
    get 'my_songs', on: :collection
    get 'my_albums', on: :collection
  end
  
  

  # Define a resource for the current user
  resource :profile, controller: 'users', only: [:show, :update, :destroy], as: 'current_user_profile'
end
