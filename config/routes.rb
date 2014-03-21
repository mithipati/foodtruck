Foodtruck::Application.routes.draw do
  root :to => "home#index"

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    resources :trucks
  end
end
