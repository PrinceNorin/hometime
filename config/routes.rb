Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  namespace :api do
    namespace :v1 do
      resources :reservations, only: [:create]
    end
  end
end
