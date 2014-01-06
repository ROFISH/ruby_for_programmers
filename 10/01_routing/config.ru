require 'rubygems'
require 'bundler/setup'
require 'yaml'

require 'action_dispatch'

routes = ActionDispatch::Routing::RouteSet.new

routes.draw do
  get '/' => 'mainpage#index'
  get '/page/:id' => 'mainpage#show'
end

class MainpageController
  def self.action(method)
    controller = self.new
    controller.method(method.to_sym)
  end

  def index(env)
    [200, {"Content-Type" => "text/html"}, ["<h1>Front Page</h1>"]]
  end

  def show(env)
    [200, {"Content-Type" => "text/html"}, ["<pre>#{env['action_dispatch.request.path_parameters'][:id]}</pre>"]]
  end
end

use ActionDispatch::ShowExceptions, ActionDispatch::PublicExceptions.new("public/")
use ActionDispatch::DebugExceptions
run routes
