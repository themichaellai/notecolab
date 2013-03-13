Notecolab::Application.routes.draw do

  devise_for :users

  resources :users

  resources :courses do
    collection do
      get '/aces_link' => 'Courses#aces'
      post '/aces_link' => 'Courses#aces_link'
    end
  end

  root to: 'StaticPages#home'

end
