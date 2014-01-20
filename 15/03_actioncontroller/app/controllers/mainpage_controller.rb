class MainpageController < ApplicationController
  def index
  end

  def show
    if params[:id] == "1"
      # do nothing, thus implicit render
    else
      render text: "<h1>404 Not Found</h1>", status: 404
    end
  end
end
