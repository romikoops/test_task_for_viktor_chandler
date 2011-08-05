RailsApp::Application.routes.draw do

  resources :games
  resources :players
  devise_for :admins
  root :to => "games#index"

end
