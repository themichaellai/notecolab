Notecolab::Application.routes.draw do

  devise_for :users

  resources :users do
    member do
      match '/aces_link' => 'Users#aces_link', :via => [:get, :post]
    end
  end

  root to: 'StaticPages#home'

end
