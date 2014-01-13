class MainpageController < AbstractController::Base
  def self.action(method)
    lambda do |env|
      controller = new
      controller.env = env
      controller.process(method)
    end
  end

  include AbstractController::Callbacks

  attr_accessor :env
  before_filter :doing_stuff

  def doing_stuff
    @hi = 'sup'
  end

  def index
    [200, {"Content-Type" => "text/html"}, ["<h1>Front Page #{@hi}</h1>"]]
  end

  def show
    [200, {"Content-Type" => "text/html"}, ["<pre>asdf #{env['action_dispatch.request.path_parameters'][:id]} #{(self.methods - Object.methods).to_yaml}</pre>"]]
  end
end
