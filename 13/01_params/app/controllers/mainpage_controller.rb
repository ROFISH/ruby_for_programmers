class MainpageController < ActionController::Metal
  include AbstractController::Callbacks
  include ActionController::Instrumentation

  before_filter :doing_stuff

  def doing_stuff
    @hi = 'sup'
  end

  def index
    self.response_body = "<h1>Front Page #{@hi}</h1>"
  end

  def show
    self.response_body = "<pre>#{params.to_yaml} #{params[:id]} #{Rails.logger.to_yaml}</pre>"
  end
end
