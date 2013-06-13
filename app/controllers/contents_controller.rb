class ContentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_collection, only: [:index, :show]
  before_filter :load_source, only: [:new, :create, :destroy]

  # GET /collections/:collection_id/contents
  # GET /collections/:collection_id/contents.json
  def index
    @contents = @collection.contents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contents }
    end
  end

  # GET /collections/:collection_id/contents/:id
  # GET /collections/:collection_id/contents/:id.json
  def show
    @content = @collection.contents.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @content }
    end
  end

  # GET /sources/:source_id/contents/new
  # GET /sources/:source_id/contents/new.json
  def new
    @content = @source.contents.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @content }
    end
  end

  # POST /sources/:source_id/contents
  # POST /sources/:source_id/contents.json
  def create
    @content = @source.contents.new(params[:content])

    respond_to do |format|
      if @content.save
        format.html { redirect_to source_content_path(@source, @content), notice: 'Content was successfully created.' }
        format.json { render json: @content, status: :created, location: @content }
      else
        format.html { render action: "new" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/:source_id/contents/:id
  # DELETE /sources/:source_id/contents/:id.json
  def destroy
    @content = @source.contents.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to source_contents_path }
      format.json { head :no_content }
    end
  end
end
