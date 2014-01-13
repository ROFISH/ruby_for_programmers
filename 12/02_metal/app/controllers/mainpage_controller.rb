class MainpageController < ActionController::Metal
  include AbstractController::Callbacks

  before_filter :doing_stuff, only:[:index]
  before_filter :doing_stuff, except:[:show]
  skip_before_filter :doing_stuff

  def doing_stuff
    @hi = 'sup'
  end

  def index
    self.response_body = "<h1>Front Page #{@hi}</h1>"
  end

  def show
    self.response_body = "<pre>asdf #{env['action_dispatch.request.path_parameters'][:id]} #{@hi}</pre>"
  end
end
