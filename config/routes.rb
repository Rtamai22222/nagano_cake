Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about', as: "about"
  get '/items' => 'public/items#index'
  get '/items/:id' => 'public/items#show/:id'
  # resources :items, only: [:index, :show]
  
  namespace :public do
    # resources :items, only: [:index, :show]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    # resources :orders, only: [:index, :show, :update]
    resources :orders, only: [:show, :update] do
      member do
        get :one_person
      end
    end
    resources :order_details, only: [:update]
  end

end
