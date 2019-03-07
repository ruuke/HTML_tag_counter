Rails.application.routes.draw do

  root 'documents#new'

  resources :documents, only: %i[index new create show destroy] do
    resources :tags, only: %i[show edit update destroy], shallow: true
  end

end
