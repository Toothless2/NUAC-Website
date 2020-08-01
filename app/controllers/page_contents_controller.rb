class PageContentsController < ApplicationController
  before_action :require_admin
  before_action :set_page_content, only: [:edit, :update]

  def new
    @page_content = PageContent.new
    @page_content.page = params[:page]
    session[:return_to] = request.referer # uses session to return to the calling page
  end

  def create
    @page_content = PageContent.new(content_params)

    respond_to do |format|
      if @page_content.save
        format.html { redirect_to session.delete(:return_to), notice: 'Post was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /page_contents/{id}/edit
  def edit
    @page_content = PageContent.find(params[:id])
    session[:return_to] = request.referer
  end

  # PATCH/PUT /page_contents/1
  # PATCH/PUT /page_contents/1.json
  def update
    respond_to do |format|
      if @page_content.update(content_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Page content was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_page_content
      @page_content = PageContent.find(params.require(:id))
    end

    def content_params
      params.require(:page_content).permit(:page, :body)
    end
end
