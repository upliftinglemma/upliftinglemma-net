require_relative '../lib/routes_helper.rb'

Rails.application.routes.draw do

    post 'login', to: 'sessions#create'
    post 'logout', to: 'sessions#destroy'

    App.all.each do |app|
        mount_app app
    end

end

