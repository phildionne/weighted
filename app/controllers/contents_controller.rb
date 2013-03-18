class ContentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_collection

  # GET collections/:collection_id/contents
  # GET collections/:collection_id/contents.json
  def index
    @contents = @collection.contents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contents }
    end
  end

  # GET collections/:collection_id/contents/:id
  # GET collections/:collection_id/contents/:id.json
  def show
    @content = @collection.contents.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @content }
    end
  end

  # GET collections/:collection_id/contents/new
  # GET collections/:collection_id/contents/new.json
  def new
    @content = @collection.contents.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @content }
    end
  end

  # GET collections/:collection_id/contents/:id/edit
  def edit
    @content = Content.find(params[:id])
  end

  # POST collections/:collection_id/contents
  # POST collections/:collection_id/contents.json
  def create
    @content = @collection.contents.new(params[:content])

    respond_to do |format|
      if @content.save
        format.html { redirect_to collection_content_path(@collection, @content), notice: 'Content was successfully created.' }
        format.json { render json: @content, status: :created, location: @content }
      else
        format.html { render action: "new" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT collections/:collection_id/contents/:id
  # PUT collections/:collection_id/contents/:id.json
  def update
    @content = @collection.contents.find(params[:id])

    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to collection_content_path(@collection, @content), notice: 'Content was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE collections/:collection_id/contents/:id
  # DELETE collections/:collection_id/contents/:id.json
  def destroy
    @content = @collection.contents.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to collection_contents_path }
      format.json { head :no_content }
    end
  end
end
