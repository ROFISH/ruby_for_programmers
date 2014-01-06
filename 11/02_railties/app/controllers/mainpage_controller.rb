class MainpageController
  def self.action(method)
    controller = self.new
    controller.method(method.to_sym)
  end

  def index(env)
    [200, {"Content-Type" => "text/html"}, ["<h1>Front Page</h1>"]]
  end

  def show(env)
    [200, {"Content-Type" => "text/html"}, ["<pre>asdfsa #{env['action_dispatch.request.path_parameters'][:id]}</pre>"]]
  end
end
