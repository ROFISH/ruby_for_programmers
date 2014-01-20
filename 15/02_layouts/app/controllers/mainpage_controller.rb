class MainpageController < ActionController::Metal
  include AbstractController::Rendering
  
  include ActionController::UrlFor
  include Rails.application.routes.url_helpers #required to tell UrlFor which routes to use
  include ActionController::Redirecting
  include ActionView::Layouts
  include ActionController::Rendering
  include ActionController::ImplicitRender

  include AbstractController::Callbacks
  include ActionController::Rescue
  include ActionController::Instrumentation

  before_filter :doing_stuff
  rescue_from ZeroDivisionError, with: :divided_by_zero

  prepend_view_path(File.join(Rails.root,'app','views'))

  def doing_stuff
    @hi = '<h1>sup</h1>'
  end

  def index
  end

  def show
    if params[:id] == "1"
      # do nothing, thus implicit render
    else
      render text: "<h1>404 Not Found</h1>", status: 404
    end
  end

  def divided_by_zero
    self.response_body = "<h1>You divided by zero. This is not allowed as you may break all of physics."
  end
end
