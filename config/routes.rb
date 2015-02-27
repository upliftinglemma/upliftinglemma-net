Rails.application.routes.draw do

    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy'

    mount UpliftingLemma::Engine, at: '/'

    constraints subdomain: 'chasing-rabbits' do
        mount UpliftingLemma::Engine, at: '/', as: 'chasing_rabbits'
    end

end

