ProgramManager::Engine.routes.draw do
  scope :api do
    get :vancouver_time_now, to: 'vancouver_time#now'

    resources :transactions, only: %i[show index]
    resources :customers, only: %i[] do
      resources :cards, only: %i[] do
        resources :transactions, only: %i[] do
          get :authorizations, on: :collection
        end
      end
    end
  end
end
