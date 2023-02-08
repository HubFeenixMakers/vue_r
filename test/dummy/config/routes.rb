Rails.application.routes.draw do
  resources :images
  root to: "images#show" , id: 1
end
