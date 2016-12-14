Rails.application.routes.draw do
  devise_for :users

  resources :chat_rooms, only: [:new,:create,:show,:index]
  resources :main, only: [:index]
  root to: "main#main"
  mount ActionCable.server => '/cable'
end
