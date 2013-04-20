class FollowsController < ApplicationController
  before_filter :authenticate_user!

  # POST /follows
  def create
    @collection = Collection.find(params[:follow][:collection_id])
    current_user.follow!(@collection)

    redirect_to @collection
  end

  # DELETE /follows/:id
  def destroy
    @collection = Follow.find(params[:id]).collection
    current_user.unfollow!(@collection)

    redirect_to @collection
  end
end
