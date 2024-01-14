Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

root to: "public/homes#top"


  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end

  namespace :public do
    root to: "homes#top"
    get 'homes/about' => 'homes#about'

    # get 'customers/my_page' => 'customers#show'
    get 'customers/information/unsubscribe' => 'customers#unsubscribe'
    get 'customers/information/withdraw' => 'customers#withdraw'
    # get 'customers/information' => 'customers#update'
    # get 'customers/information/edit' => 'customers#edit'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'

    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'

    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:new, :confirm, :complete, :create, :index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
