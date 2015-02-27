Rails.application.routes.draw do

    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy'

    mount UpliftingLemma::Engine, at: '/'

end

