Rails.application.routes.draw do
  get '/' => 'mainpage#index'
  resources :pages
end
