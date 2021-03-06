Rails.application.routes.draw do
  devise_for :users

  root 'patients#index'
  resources :certificates, only: [] do
    get :download, on: :collection
  end

  resources :diseases, only: [:index, :new, :create, :edit, :update]
  resources :medicines, only: [:index, :new, :create, :edit, :update]
  resources :patients, only: [:index, :new, :create, :edit, :update] do
    resources :anamneses, only: [:new, :create, :edit, :update]
    resources :consultations, only: [:index, :new, :create, :edit, :update]
    get :special, on: :collection
  end
  resources :settings, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    resources :patients, only: [] do
      resources :consultations, only: [:index] do
        collection do
          post   'previous'
          post   'next'
          post   'last'
          delete 'destroy'
        end
      end
    end

    resources :diseases, only: [:index]
    resources :medicines, only: [:index]
    resources :settings, only: [:index, :update]
  end
end
