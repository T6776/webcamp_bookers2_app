Rails.application.routes.draw do
  get 'users/show'
  devise_for :users


  root to: 'homes#top'
  get 'home/about' => 'homes#about'


  resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end