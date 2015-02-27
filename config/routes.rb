Rails.application.routes.draw do

    post 'login' => 'sessions#create'
    post 'logout' => 'sessions#destroy'

    mount UpliftingLemma, at: '/'

end

