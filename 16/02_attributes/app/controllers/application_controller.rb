class ApplicationController < ActionController::Base
  before_filter :doing_stuff
  rescue_from ZeroDivisionError, with: :divided_by_zero

  def doing_stuff
    @hi = '<h1>sup</h1>'
  end

  def divided_by_zero
    self.response_body = "<h1>You divided by zero. This is not allowed as you may break all of physics."
  end
end
