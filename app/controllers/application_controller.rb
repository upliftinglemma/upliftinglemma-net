class ApplicationController < ActionController::Base
    include BrowserID::Rails::Base

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    alias_method :authenticated?, :browserid_authenticated?
    alias_method :current_user, :browserid_current_user
end
