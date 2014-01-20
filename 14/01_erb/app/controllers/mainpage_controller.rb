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
    template = ERB.new File.read(File.join(Rails.root,'app','views','mainpage','index.html.erb'))
    self.response_body = template.result(binding)
  end

  def show
    template = ERB.new File.read(File.join(Rails.root,'app','views','mainpage','show.html.erb'))
    self.response_body = template.result(binding)
  end

  def divided_by_zero
    self.response_body = "<h1>You divided by zero. This is not allowed as you may break all of physics."
  end
end
