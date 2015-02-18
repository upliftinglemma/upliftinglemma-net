Rails.application.routes.draw do

    post 'login' => 'sessions#create'
    post 'logout' => 'sessions#destroy'

end

Routing::AppRouter.route_all

