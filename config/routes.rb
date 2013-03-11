Notecolab::Application.routes.draw do

  devise_for :users

  resources :users

  root to: 'StaticPages#home'

end
