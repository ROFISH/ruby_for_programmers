class MainpageController < ActionController::Metal
  include AbstractController::Rendering
  
  include ActionController::UrlFor
  include Rails.application.routes.url_helpers #required to tell UrlFor which routes to use
  include ActionController::Redirecting
  include ActionController::Rendering
  include ActionController::ImplicitRender

  include AbstractController::Callbacks
  include ActionController::Rescue
  include ActionController::Instrumentation

  before_filter :doing_stuff
  rescue_from ZeroDivisionError, with: :divided_by_zero

  def doing_stuff
    @hi = 'sup'
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

  def render_to_body(*args)
    if args.is_a?(Array) && args.first.is_a?(Hash)
      options = args.first
    else
      options = {}
    end

    _process_options(options)

    if options[:text]
      options[:text]
    else
      template = ERB.new File.read(File.join(Rails.root,'app','views',params[:controller].to_s,"#{params[:action]}.html.erb"))
      template.result(binding)
    end
  end

  def rendered_format
    Mime::HTML
  end
end
