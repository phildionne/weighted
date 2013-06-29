class SearchesController < ApplicationController

  # GET /search
  def show
    # show.html.erb
  end

  # POST /search
  def create
    @results = Collection.limit(20)

    respond_to do |format|
      format.html { render action: :show }
      format.json { render json: @search }
    end
  end
end
