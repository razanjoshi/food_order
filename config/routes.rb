Rails.application.routes.draw do
  get 'orders/index'

  resources :products
  resources :orders, only:[:index]
  resources :order_items
  resource :carts do
    get :show
    post :order_now
  end
  match 'order_now' => 'carts#order_now', :via => :post
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
