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
  
  scope module: 'public' do
    resources :items, only: [:index, :show]  
    resources :cart_items, only: [:index, :create, :update]
  end

  namespace :public do
    # resources :items, only: [:index, :show]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      member do
        get :one_person
      end
    end
    resources :order_details, only: [:update]
  end

end
