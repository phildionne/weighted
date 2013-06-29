class SourcesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_collection, only: [:index, :new, :create]

  # GET /collections/:collection_id/sources
  # GET /collections/:collection_id/sources.json
  def index
    @sources = @collection.sources

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sources }
    end
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    @source = Source.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @source }
    end
  end

  # GET /collections/:collection_id/sources/new
  # GET /collections/:collection_id/sources/new.json
  def new
    @source = @collection.sources.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @source }
    end
  end

  # GET /sources/1/edit
  def edit
    @source = Source.find(params[:id])
  end

  # POST /collections/:collection_id/sources
  # POST /collections/:collection_id/sources.json
  def create
    @source = @collection.sources.new(params[:source])

    respond_to do |format|
      if @source.save
        format.html { redirect_to @collection, notice: 'Source was successfully created.' }
        format.json { render json: @source, status: :created, location: @source }
      else
        format.html { render action: :new }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sources/1
  # PUT /sources/1.json
  def update
    @source = Source.find(params[:id])

    respond_to do |format|
      if @source.update_attributes(params[:source])
        format.html { redirect_to root_path, notice: 'Source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source = Source.find(params[:id])
    @source.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
