class MainpageController < ActionController::Metal
  include AbstractController::Callbacks
  include ActionController::Instrumentation
  include ActionController::Rescue
  include ActionController::UrlFor
  include Rails.application.routes.url_helpers #required to tell UrlFor which routes to use
  include ActionController::Redirecting

  before_filter :doing_stuff
  rescue_from ZeroDivisionError, with: :divided_by_zero

  def doing_stuff
    @hi = 'sup'
  end

  def index
    #redirect_to "/show/butts"
    redirect_to :action=>:show, :id=>"butts"
  end

  def show
    self.response_body = "<pre>#{params.to_yaml} #{params[:id]} #{Rails.logger.to_yaml}</pre>"
  end

  def divided_by_zero
    self.response_body = "<h1>You divided by zero. This is not allowed as you may break all of physics."
  end
end
