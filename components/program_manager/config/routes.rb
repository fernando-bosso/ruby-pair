ProgramManager::Engine.routes.draw do
  scope :api do
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
