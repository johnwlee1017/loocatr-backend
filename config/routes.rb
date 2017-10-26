Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :bathrooms do
    resources :reviews
    resources :time_frames
    resources :images, only: [:index, :create]
    resources :use_histories, only: [:create]
  end
end
