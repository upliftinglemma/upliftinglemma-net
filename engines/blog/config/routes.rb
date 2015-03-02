Blog::Engine.routes.draw do
    root 'home#show'
    resources :articles
end
