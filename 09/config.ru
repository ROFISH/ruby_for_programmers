require 'rubygems'
require 'bundler/setup'
require 'yaml'

run Proc.new {|env|
  if env["PATH_INFO"] == "/"
    [200, {"Content-Type" => "text/html"}, ["<h1>Front Page</h1>"]]
  else
    [404, {"Content-Type" => "text/html"}, ["<h1>Not Found</h1>"]]
  end
}
