Notecolab::Application.routes.draw do

  devise_for :users

  resources :users

  resources :courses do
    resources :notes
    collection do
      get '/aces_link' => 'Courses#aces'
      post '/aces_link' => 'Courses#aces_link'
    end
    resources :users, only: [:index], controller: 'courses/users'
    post '/join' => 'Courses#join'
    post '/leave' => 'Courses#leave'
  end

  root to: 'StaticPages#home'

end
