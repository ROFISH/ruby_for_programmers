class MainpageController < ActionController::Metal
  include AbstractController::Callbacks
  include ActionController::Instrumentation
  include ActionController::Rescue

  before_filter :doing_stuff
  rescue_from ZeroDivisionError, with: :divided_by_zero

  def doing_stuff
    @hi = 'sup'
  end

  def index
    #self.content_type = "text/text"
    self.response_body = "<h1>Front Page #{@hi}</h1>"
  end

  def show
    1/0
    self.response_body = "<pre>#{params.to_yaml} #{params[:id]} #{Rails.logger.to_yaml}</pre>"
  end

  def divided_by_zero
    self.response_body = "<h1>You divided by zero. This is not allowed as you may break all of physics."
  end
end
