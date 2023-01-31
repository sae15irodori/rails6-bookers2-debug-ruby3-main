Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_for :users#最終行より移動

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]#追加　いいね機能
      resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #devise_for :usersこれをresources :usersの上へ無限ループの原因となる。
end#追記