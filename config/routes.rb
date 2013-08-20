# coding: utf-8
DeviseRussian::Engine.routes.draw do
  devise_for :users, {
    :module => :devise,
    :path => "",
    :path_names => {
      :sign_in  => "login",
      :sign_out => "logout",
      :sign_up  => "register"
    },
    :controllers => {
      :registrations => "registrations"
    }
  }

  # Авторизации пользователя
  resources :authentications, :only => [:index, :create, :destroy]

  # Вход через социальные сети
  match "/:provider/callback", :to => "authentications#create", :via => [:get, :post]
  match "/failure", :to => "authentications#failure", :via => [:get, :post]
end
