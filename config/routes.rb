Rails.application.routes.draw do

  resources :documents, only: %i[index show destroy] do
    resources :tags, only: %i[show edit update destroy], shallow: true
  end
  
end
