Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  root 'documents#new'

  resources :documents, only: %i[index new create show destroy] do
    resources :tags, only: %i[show edit update destroy], shallow: true
  end

end
