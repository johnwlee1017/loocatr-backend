Rails.application.routes.draw do
  resources :bathrooms do
    resources :reviews
    resources :time_frames
    resources :images, only: [:index, :craete]
    resources :use_histories, only: [:craete]
  end
end
