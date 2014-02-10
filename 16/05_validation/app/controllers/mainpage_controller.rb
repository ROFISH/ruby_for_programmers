class MainpageController < ApplicationController
  def index
  end

  def show
    @page = Page.where(handle:params[:id]).first

    if @page.blank?
      render text: "<h1>404 Not Found</h1>", status: 404
    end

    #implicit render
  end
end
