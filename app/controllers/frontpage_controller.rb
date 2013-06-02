class FrontpageController < ApplicationController

  # GET /
  def show

    if current_user

      @collections = current_user.followed_collections
      @contents = Content.where(collection_id: @collections.map(&:id))

      render 'homepage'
    else
      render 'frontpage'
    end
  end
end
