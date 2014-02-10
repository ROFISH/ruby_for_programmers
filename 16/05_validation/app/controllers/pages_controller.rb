class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    @page.name = params['page']['name']
    @page.handle = params['page']['handle']
    @page.body_text = params['page']['body_text']
    if @page.save
      redirect_to @page
    else
      render :action=>:edit
    end
  end
end
