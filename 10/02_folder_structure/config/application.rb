require File.expand_path('../boot', __FILE__)

Bundler.require

module GenericCMS
  class Application < Rails::Application
    # you could put some custom stuff here if you wanted
  end
end

require File.expand_path('../../app/controllers/mainpage_controller', __FILE__)
