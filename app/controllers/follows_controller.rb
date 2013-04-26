class FollowsController < ApplicationController
  before_filter :authenticate_user!

  # POST /follows
  def create
    @collection = Collection.find(params[:follow][:collection_id])
    current_user.follow!(@collection)

    respond_to do |format|
      format.html { redirect_to @collection }
      format.js # create.js.erb
    end
  end

  # DELETE /follows/:id
  def destroy
    @collection = Follow.find(params[:id]).collection
    current_user.unfollow!(@collection)

    respond_to do |format|
      format.html { redirect_to @collection }
      format.js # destroy.js.erb
    end
  end
end
