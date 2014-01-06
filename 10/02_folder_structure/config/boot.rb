# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

# some more requires
require 'yaml'
require 'action_dispatch'

module Rails
  class << self
    attr_accessor :application
  end

  class Application
    attr_accessor :routes

    class << self
      def inherited(base)
        super
        Rails.application ||= base.instance
      end

      def instance
        @instance ||= new
      end
    end

    def routes
      @routes ||= ActionDispatch::Routing::RouteSet.new
      @routes.append(&Proc.new) if block_given?
      @routes
    end
  end
end
