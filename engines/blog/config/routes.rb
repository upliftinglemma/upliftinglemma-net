Blog::Engine.routes.draw do
    root 'articles#index'

    resources :articles do
        resources :comments, controller: '/comments', only: [:create, :update, :destroy]
    end
end
