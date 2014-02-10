require File.expand_path('../boot', __FILE__)

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_record/railtie'

Bundler.require

module GenericCMS
  class Application < Rails::Application
    # you could put some custom stuff here if you wanted

    config.secret_key_base = "rails really wants this to be defined"
  end
end
