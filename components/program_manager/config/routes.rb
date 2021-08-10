ProgramManager::Engine.routes.draw do
  scope :api do
    resources :transactions, only: %i[show index]
  end
end
