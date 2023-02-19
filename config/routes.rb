Rails.application.routes.draw do
  # namespace :public do
  #   get 'orders/new'
  #   get 'orders/index'
  #   get 'orders/show'
  # end
  # namespace :public do
  #   get 'customers/show'
  #   get 'customers/edit'
  # end
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'

  scope module: 'public' do
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
        # delete :destroy_all, on: :collection 
    end
    resources :orders, only: [:index, :new, :show, :create] do
      collection do
        post :confirm
        get :conplete
      end  
    end
  end

  # namespace :public do
  #   # resources :items, only: [:index, :show]
  # end

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
