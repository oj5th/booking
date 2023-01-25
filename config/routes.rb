Rails.application.routes.draw do
  resources :reservations, except: [:update] do
    collection do
      put :update
    end
  end
  root to: "reservations#index"
end
