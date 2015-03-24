class ApplicationController < ActionController::Base
  include BrowserID::Rails::Base
  include Pundit

  include LoadsModel

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  alias_method :authenticated?, :browserid_authenticated?

  helper_method :authenticated?, :current_user, :app_route, :get_app

  before_action :do_load_and_authorize_app


  def current_user
    if authenticated?
      @decorated_current_user ||= browserid_current_user.decorate
    end
  end


  private


  def user_for_paper_trail
    browserid_current_user
  end


  def app_route app = nil
    app = get_app app

    route = send app.route_name
    subdomain = if app.default? then false else app.slug end

    EngineRouteModifier.new route, subdomain: subdomain
  end


  def get_app app
    case app
    when nil then @app
    when String, Symbol then App.friendly.find(app.to_s).decorate
    else app
    end
  end


  ##
  # Determine which app we are currently running based on the subdomain, and
  # make sure we are authorized to access it.
  #
  def do_load_and_authorize_app
    @app =
      if request.subdomain.blank?
        App.default
      else
        get_app request.subdomain
      end

    authorize @app, :access?
  end


  ##
  # Override the user passed to pundit
  #
  def pundit_user
    AppUser.new @app, current_user
  end
end

