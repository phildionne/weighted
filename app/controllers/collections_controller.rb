class CollectionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collections }
    end
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    @collection = Collection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/new
  # GET /collections/new.json
  def new
    @collection = Collection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/1/edit
  def edit
    @collection = Collection.find(params[:id])
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render json: @collection, status: :created, location: @collection }
      else
        format.html { render action: "new" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /collections/1
  # PUT /collections/1.json
  def update
    @collection = Collection.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_path }
      format.json { head :no_content }
    end
  end

  # GET /collections/1/followers
  # GET /collections/1/followers.json
  def followers
    @collection = Collection.find(params[:id])
    @users = @collection.followers

    respond_to do |format|
      format.html { render 'followers' }
      format.json { render json: @users }
    end
  end
end
